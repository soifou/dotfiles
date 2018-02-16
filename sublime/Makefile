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
	if [ -d $(SUBLIME_DIR) ]; then
		mkdir -p "$(SUBLIME_DIR)/Installed Packages"
		curl -o "$(SUBLIME_DIR)/Installed Packages/Package Control.sublime-package" $(PACKAGE_URL)
		# wget -P "$(SUBLIME_DIR)/Installed Packages" $(PACKAGE_URL)
		echo "Package control has been installed!"
	fi

linter:
	if [ -d $(SUBLIME_DIR) ]; then
		mkdir -p "$(SUBLIME_DIR)/Packages"
		git clone https://github.com/SublimeLinter/SublimeLinter "$(SUBLIME_DIR)/Packages
		cd "$(SUBLIME_DIR)/Packages/SublimeLinter"; git checkout 4.0.0-rc.9.4
		echo "SublimeLinter 4.0.0 has been installed!"
	fi

.PHONY: all
