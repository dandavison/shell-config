__autojump_src_dir=~/lib/shell/autojump
if [ "$BASH_VERSION" ] && [ -n "$PS1" ] && echo $SHELLOPTS | grep -v posix >>/dev/null; then
        __autojump_src=$__autojump_src_dir/autojump.bash
elif [ "$ZSH_VERSION" ] && [ -n "$PS1" ]; then
        __autojump_src=$__autojump_src_dir/autojump.zsh
fi

if [ -e "$__autojump_src" ] ; then
    . $__autojump_src
    # Redefine autojump's j so as not to echo the new location
    j () { __new_path="$(autojump $@)"; [ -n "$__new_path" ] && cd "$__new_path" ; }
fi
