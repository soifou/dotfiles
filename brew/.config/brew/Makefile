init:
	ln -sf Brewfile.$(shell uname -n) Brewfile
install: Brewfile ## Install dependencies from Brewfile
	brew bundle install

dump: Brewfile ## Dump current dependencies to Brewfile
	brew bundle dump --file=- > Brewfile.$(shell uname -n)
