.ONESHELL:
.SILENT:

PACKAGE_URL=https://packagecontrol.io/Package%20Control.sublime-package
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Linux)
	SUBLIME_DIR="$$HOME/.config/sublime-text-3"
endif

ifeq ($(UNAME_S),Darwin)
	SUBLIME_DIR="$$HOME/Library/Application Support/Sublime Text 3"
endif

all:
	mkdir -p $(SUBLIME_DIR)/{Backup,Cache,Index,Installed\ Packages,Local}
	if [ -f "$(SUBLIME_DIR)/Installed Packages/Package Control.sublime-package" ]; then
		echo "Package control is already installed!"
	else
		curl -o "$(SUBLIME_DIR)/Installed Packages/Package Control.sublime-package" $(PACKAGE_URL)
		echo "Package control has been installed!"
	fi

.PHONY: all
