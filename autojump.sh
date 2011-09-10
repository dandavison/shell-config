#!/usr/bin/env bash


# If conditions copied from /usr/homebrew/etc/autojump
if [ "$BASH_VERSION" ] && [ -n "$PS1" ] && echo $SHELLOPTS | grep -v posix >>/dev/null; then

    . ~/lib/bash/autojump.bash
    # Redefine autojump's j so as not to echo the new location
    function j { new_path="$(autojump $@)"; [ -n "$new_path" ] && cd "$new_path" ; }
fi
