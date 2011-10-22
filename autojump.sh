__autojump_src=/usr/homebrew/etc/autojump

if [ -e "$__autojump_src" ] ; then
    . $__autojump_src
    # Redefine autojump's j so as not to echo the new location
    j () { __new_path="$(autojump $@)"; [ -n "$__new_path" ] && cd "$__new_path" ; }
fi
