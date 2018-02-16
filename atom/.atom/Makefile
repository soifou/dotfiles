
# https://discuss.atom.io/t/installed-packages-list-into-single-file/12227/2

APM := $(shell command -v apm 2> /dev/null)
PACKAGES := ./package-list.txt

all: check
	@while read module; do \
		echo "Installing module $$module..."; \
		apm i "$$module" || true; \
	done <$(PACKAGES)
	@echo "All packages has been installed!"

list: check
	@echo "Updating list extensions..."
	@apm list --installed --bare | awk -F@ '{print $$1}' > $(PACKAGES)
	@echo "Your list is up to date!"

check:
ifndef APM
	$(error apm is not available, please install atom first.)
endif

.PHONY: all list check
