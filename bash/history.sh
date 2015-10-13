export HISTFILESIZE=10000
export HISTTIMEFORMAT="%s "
shopt -s cmdhist                             # store multiline entries as a single history entry

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"
PROMPT_COMMAND=$PROMPT_COMMAND'history 1 >> ~/.bash_eternal_history'
