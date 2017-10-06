# Sublime and linters

In order to get SublimeLinters working, I had to installed some linters tools on my system. 

Here is a memo list.

## CSS

Prerequisite: nodeJS, npm (with nvm)
Install csslint globally
> $ npm install -g csslint

## JS

Prerequisite: nodeJS, npm (with nvm)
Install jshint globally
> $ npm install -g jshint

## PHP

System php (with brew install php7)
> $ brew tap homebrew/dupes
> $ brew tap homebrew/versions
> $ brew tap homebrew/homebrew-php
> $ brew install --with-openssl curl
> $ brew install --with-homebrew-curl --with-apache php71
> $ brew services start homebrew/php/php71
> $ brew info php71
> $ brew install homebrew/php/composer
> $ brew link composer

SublimeLinter-php use `php -l`. Check PHP is in your path.

## Ruby

Install rubocop globally
> gem install rubocop

## Python

Install pep8 globally (via pip3 for better perf)
> pyenv global 3.5.3
> pip install pep8