source ~/src/counsyl/1p/config/counsyl.sh
if ! is_zsh; then
    source ~/src/facet/completion/bash/facet
    source ~/src/delta/etc/completion/completion.bash
    complete -F _delta d
fi
