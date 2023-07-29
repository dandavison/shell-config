alias ','=wormhole
alias 'vv'=wormhole '""' '"code ."'

function wormhole-switch-widget() {
  BUFFER=','
  zle accept-line
}

function wormhole-code-widget() {
  BUFFER='vv'
  zle accept-line
}

zle -N wormhole-switch-widget
zle -N wormhole-code-widget
