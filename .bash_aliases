# some more ls aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias json='python -mjson.tool'
alias ..="cd .."
alias ...="cd ../.."

# Aliases
alias vim=nvim
alias ll="exa -la"
alias lld="exa -lda"


