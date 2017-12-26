# Sublime and linters

In order to get SublimeLinters working, I had to installed some linters tools on my system. 

Here is a memo list.

## CSS

> $ npm install -g csslint

## JS

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

> $ gem install rubocop

## Python

> $ pip install pycodestyle

## Docker

> $ npm install -g dockerfilelint@">=1.4.0"