# use recent programs
alias g++="g++-13"

# convenience
alias reload="exec $SHELL"
alias cls="clear"
alias fo="fzf --print0 | xargs -0 -o nvim"

alias venv="python3 -m venv"
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# dirs
alias ws="cd ~/Workspace"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias c="cd ~/.config"
alias cpn="cd ~/cp-notebook"

# git
alias gc="git commit"
alias gp="git push"
alias gs="git status"
