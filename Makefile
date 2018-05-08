
.PHONY: test

all: test

test:
	cd test && ./test.sh

clean:
	find . -type f -name "output.xml" -delete -o -name "*.swp" -delete
