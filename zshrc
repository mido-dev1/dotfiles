pfetch
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
plugins=(aliases archlinux)

source $ZSH/oh-my-zsh.sh
# Example aliases
alias zconfig="nvim ~/.zshrc"
alias nvconfig="nvim ~/.config/nvim"
eval "$(starship init zsh)"

# Pywal
(cat $HOME/.cache/wal/sequences &)
cat $HOME/.cache/wal/sequences
source $HOME/.cache/wal/colors-tty.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit light-mode for \
  hlissner/zsh-autopair \
  zdharma-continuum/fast-syntax-highlighting \
  MichaelAquilina/zsh-you-should-use \
  zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab

zinit ice wait'3' lucid
zinit light zsh-users/zsh-history-substring-search

zinit ice wait'2' lucid
zinit light zdharma-continuum/history-search-multi-word

# FZF
zinit ice from"gh-r" as"command"
zinit light junegunn/fzf-bin

# BAT
zinit ice wait lucid from"gh-r" as"program" mv"*/bat -> bat" atload"export BAT_THEME='Nord'"
zinit light sharkdp/bat

# alias
alias ls='eza --icons -F'
# export dir="/home/mehdi/.config/wallpapers/"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/python/3.12.0/bin:$PATH"
alias python="/opt/python/3.12.0/bin/python3.12"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/python/3.12.0/lib
alias dotfiles='nvim $HOME/gitRepos/dotfiles/'
