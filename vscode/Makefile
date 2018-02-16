
# https://code.visualstudio.com/docs/editor/command-line

CODE := $(shell command -v code 2> /dev/null)
PACKAGES := ./package-list.txt

all: check
	@while read module; do \
		echo "Installing module $$module..."; \
		code --install-extension "$$module" || true; \
	done <$(PACKAGES)
	@echo "All packages has been installed!"

list: check
	@echo "Updating list extensions..."
	code --list-extensions > $(PACKAGES)
	@echo "Your list is up to date!"

check:
ifndef CODE
	$(error code is not available, please install visual studio code first.)
endif

.PHONY: all list check