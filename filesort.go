// Package filesort implement a simple filesorter, which goal is for me to learn go.
package main

import (
	"fmt"
	"io"
	"io/fs"
	"log"
	"os"
	"strings"
)

func getDirname() string {
	var root string
	//TODO: get argument or working directory instead by default
	fmt.Print("Where to sort ? : ")
	num, err := fmt.Scanf("%s", &root)
	if err != nil {
		log.Fatal(err)
	}
	if num != 1 {
		log.Fatal("There must be only one place to sort.")
	}

	isValid := fs.ValidPath(root)
	if !isValid {
		log.Fatal("You must enter a valid path format")
	}

	return root
}

func openDir(dirname string) []fs.DirEntry {
	wd, err := os.Getwd()

	if err != nil {
		log.Fatal(err)
	}

	fileSystem := os.DirFS(wd)

	ls, err := fs.ReadDir(fileSystem, dirname)

	if err != nil {
		log.Fatal(err)
	}

	return ls
}

var exts = map[string]string{
	"iso":    "Images_isos",
	"sha256": "Images_isos",
	"pdf":    "PDFs",
	"xlsx":   "Bureautique",
	"doc":    "Bureautique",
	"html":   "HTMLS",
	"TXT":    "Textes",
	"zip":    "Archives",
	"gz":     "Archives",
	"csv":    "Données",
}

func move(file string, dossier string) {
	err := os.Mkdir(dossier, 0744)
	if err != nil && !os.IsExist(err) {
		log.Fatal(err)
	}

	inputFile, err := os.Open(file)
	if err != nil {
		log.Fatal(err)
	}

	outputFile, err := os.Create(dossier + "/" + file)
	if err != nil {
		log.Fatal(err)
	}

	_, err = io.Copy(outputFile, inputFile)
	if err != nil {
		log.Fatal(err)
	}

	err = inputFile.Close()
	if err != nil {
		log.Fatal(err)
	}

	err = outputFile.Close()
	if err != nil {
		log.Fatal(err)
	}

	err = os.Remove(file)
	if err != nil {
		log.Fatal(err)
	}
}

func sort(file fs.DirEntry) {
	slice := strings.Split(file.Name(), ".")
	ext := slice[len(slice)-1:][0]

	if exts[ext] != "" {
		move(file.Name(), exts[ext])
	} else {
		fmt.Printf("%s n'est pas encore reconnu\n", file.Name())
	}
}

func main() {
	root := getDirname()

	ls := openDir(root)

	for _, v := range ls {
		if !v.IsDir() {
			sort(v)
		}
	}
}
