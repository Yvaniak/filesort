#this justfile is generated

default:
  just --list

build:
  go build

run: build
  go run .




pre-commit-all:
  pre-commit run --all-files








all: build   pre-commit-all 

