# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions
alias vi='vim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

if [[ $- == *i* ]]; then
    if [[ -z "$TMUX" ]] && command -v tmux > /dev/null; then
        tmux attach-session -t session || tmux new-session -s session
    fi
fi

source /etc/bash_completion.d/git-prompt

PROMPT_COMMAND=_prompt

_prompt() {
    local exit_code="$?"
    PS1='\[\e[1;35m\]\u@\h \[\e[0;33m\]\w\[\e[36m\]$(__git_ps1 " (%s)") '
    if [ $exit_code != 0 ]; then
        PS1+='\[\e[0;31m\]'
    else
        PS1+='\[\e[0;32m\]'
    fi
    PS1+='$(head -c $(($COLUMNS-$(echo "\u@\h \w$(__git_ps1 " (%s)")" | wc -c))) /dev/zero | tr "\0" ">")\n\[\e[1;36m\]\$\[\e[0m\] '
    export PS1
}

