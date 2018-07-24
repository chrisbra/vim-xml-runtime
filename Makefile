PLUGIN=$(shell basename "$$PWD")
.PHONY: test

all: zip

zip:
	@rm -f $(PLUGIN).zip; zip $(PLUGIN).zip ftplugin/*.vim indent/*.vim autoload/*.vim

test:
	cd test && ./test.sh

clean:
	find . -type f -name "output.xml" -delete -o -name "*.swp" -delete
