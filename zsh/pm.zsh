alias ','='nu ~/src/pm/pm-switch.nu'
alias 'vv'='nu ~/src/pm/pm-switch-code.nu'

function pm-switch-widget() {
  BUFFER=','
  zle accept-line
}

function pm-switch-code-widget() {
  BUFFER='vv'
  zle accept-line
}

zle -N pm-switch-widget
zle -N pm-switch-code-widget
