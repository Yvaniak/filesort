BIN=filesort

bin/${BIN} : ${BIN}.go
	go build -o bin/${BIN}

clean :
	go clean
	if [ -d bin ]; then\
		rm -r bin;\
	fi

all: bin/filesort

.PHONY: clean all
