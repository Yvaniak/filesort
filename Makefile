BIN=filesort

bin/${BIN}: ${BIN}.go
	go build -o bin/${BIN}

clean:
	go clean
	if [ -d bin ]; then\
		rm -r bin;\
	fi

run: bin/${BIN}
	./bin/${BIN}

all: bin/${BIN}

.PHONY: clean all run
