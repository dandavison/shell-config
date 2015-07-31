# http://www.debian-administration.org/articles/543
export HISTIGNORE="[ \t]*:&" # '&' supresses duplicate entries
export HISTFILESIZE=10000
export HISTTIMEFORMAT="%s "
shopt -s cmdhist                             # store multiline entries as a single history entry

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"
PROMPT_COMMAND=$PROMPT_COMMAND'history 1 >> ~/.bash_eternal_history'
