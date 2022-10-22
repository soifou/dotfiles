# .SILENT:
.DEFAULT_GOAL= install
.PHONY: install

# Params
BASE_FOLDER=vendors
LAUNCHER_URL=https://raw.githubusercontent.com/adi1090x/rofi/master/files/launchers

install:
	mkdir -p $(BASE_FOLDER)/shared
	touch $(BASE_FOLDER)/shared/colors.rasi
	touch $(BASE_FOLDER)/shared/fonts.rasi

	# install base launchers
	curl -fsSL $(LAUNCHER_URL)/type-1/style-5.rasi > $(BASE_FOLDER)/launcher1.5.rasi
	curl -fsSL $(LAUNCHER_URL)/type-4/style-6.rasi > $(BASE_FOLDER)/launcher4.6.rasi

	# remove modi from launcher
	sed -i '/modi:/d' $(BASE_FOLDER)/launcher1.5.rasi
	sed -i '/modi:/d' $(BASE_FOLDER)/launcher4.6.rasi
