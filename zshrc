PATH=/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# Add private exports
source $HOME/dotfiles/private
# Add custom exports
source $HOME/dotfiles/exports
# Add custom shell functions
source $HOME/dotfiles/functions
# Add custom aliases
source $HOME/dotfiles/aliases

# Add antigen defaults
source $HOME/.antigen/antigen.zsh
source $HOME/dotfiles/antigenrc