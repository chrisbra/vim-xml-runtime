PLUGIN=$(shell basename "$$PWD")
.PHONY: test submit

all: test

zip:
	@rm -f $(PLUGIN).zip; zip $(PLUGIN).zip ftplugin/*.vim indent/*.vim autoload/*.vim syntax/*.vim

test:
	cd test && ./test.sh -v && cd .. && $(MAKE) clean >/dev/null

clean:
	find . -type f -name "output.xml" -delete -o -name "*.swp" -delete

submit:
	@echo "Set environment variable '\$$MSG' to the tag message, like this:"
	@echo "MSG='My tag message'"
	@echo "git tag -f -s \`date +'%Y%m%d'\` -m \"\$$MSG\""
