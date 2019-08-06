# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


shopt -s histappend
shopt -s checkwinsize
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working tree clean)" ]] && echo "*"
}

if [[ $(which git) != "" ]];then
    function parse_git_branch {
        git_status="$(git status 2> /dev/null)"
        pattern="^[#\s+]*On branch ([^${IFS}]*)"
        if [[ ! ${git_status}} =~ "working tree clean" ]]; then
            state="*"
        fi
        # add an else if or two here if you want to get more specific

        if [[ ${git_status} =~ ${pattern} ]]; then
            branch=${BASH_REMATCH[1]}
            echo "[${branch}${state}]"
        fi
    }
else
    function parse_git_branch {
    return 
    }
fi

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
        if [[ -f ~/.dir_colors ]] ; then
                eval $(dircolors -b ~/.dir_colors)
        elif [[ -f /etc/DIR_COLORS ]] ; then
                eval $(dircolors -b /etc/DIR_COLORS)
        fi

if [[ ${EUID} == 0 ]] ; then
        PS1='\[\033[01;31m\]\u@\h\[\033[01;34m\] \w$(parse_git_branch) \$\[\033[00m\] '
else
        PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w$(parse_git_branch) \$\[\033[00m\] '
fi

export HISTCONTROL=ignoreboth


# Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
if [[ $(which pyenv) != "" ]];then 
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Erlang
export PATH="$HOME/.exenv/bin:$PATH"
if [[ $(which exenv) != "" ]];then 
    eval "$(exenv init -)"
fi

# Go
[[ -f ~/.gvm/scripts/gvm ]] && source $HOME/.gvm/scripts/gvm

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# OCaml
test -r $HOME/.opam/opam-init/init.sh && . $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true


# Nix
test -r $HOME/.nix-profile/ && . $HOME/.nix-profile/etc/profile.d/nix.sh

function apt_key_fetch() {
   if [[ $1 !=  '' ]];then
      echo '[i] install key '$1	
      apt-key adv --recv-keys  --keyserver keyserver.ubuntu.com  $1
   else
      echo '[w] usage apt_key_fetch key_id'
   fi
}

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [ -f ~/.bash_export ]; then
    . ~/.bash_export
fi
#local


if [ -f ~/.bash_export_local ]; then
    . ~/.bash_export_local
fi

if [ -f ~/.bash_aliases_local ]; then
    . ~/.bash_aliases_local
fi

if [ -f ~/.bashrc_local ]; then
    . ~/.bashhrc_local
fi
