alias ','=twitch
alias 'vv'=twitch '""' '"code ."'

function twitch-switch-widget() {
  BUFFER=','
  zle accept-line
}

function twitch-code-widget() {
  BUFFER='vv'
  zle accept-line
}

zle -N twitch-switch-widget
zle -N twitch-code-widget
