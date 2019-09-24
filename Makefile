PLUGIN=$(shell basename "$$PWD")
.PHONY: test submit

all: test

zip:
	@rm -f $(PLUGIN).zip; zip $(PLUGIN).zip ftplugin/*.vim indent/*.vim autoload/*.vim syntax/*.vim

test:
	cd test && VIM_XML_RT=$(shell echo "$$PWD") ./test_runtime.sh -v && cd .. && $(MAKE) clean >/dev/null

clean:
	find . -type f -name "output.*" -delete -o -name "*.swp" -delete -o -name "SKIPPED" -delete -o -name "X*" -delete

submit:
	@echo "Set environment variable '\$$MSG' to the tag message, like this:"
	@echo "MSG='My tag message'"
	@echo "git tag -f -s \`date +'%Y%m%d'\` -m \"\$$MSG\""
