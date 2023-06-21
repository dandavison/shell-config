alias ','='nu ~/src/pm/pm.nu'

function pm-switch-widget() {
  BUFFER=','
  zle accept-line
}

zle -N pm-switch-widget
