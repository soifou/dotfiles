# https://github.com/VSCodium/vscodium
# https://code.visualstudio.com/docs/editor/command-line

CODE := $(shell command -v vscodium 2> /dev/null)
PACKAGES := ./package-list

all: check
	@while read module; do \
		echo "Installing module $$module..."; \
		$(CODE) --install-extension "$$module" || true; \
	done <$(PACKAGES)
	@echo "All packages has been installed!"

list: check
	@echo "Updating list extensions..."
	$(CODE) --list-extensions > $(PACKAGES)
	@echo "Your list is up to date!"

check:
ifndef CODE
	$(error vscodium is not available in PATH, please install VSCodium first. If VSCodium is installed, select "Shell command: Install 'vscodium' command in PATH" from your command palette)
endif

.PHONY: all list check