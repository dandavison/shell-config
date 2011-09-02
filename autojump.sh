#!/usr/bin/env bash

if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
  # Redefine autojump's j so as not to echo the new location
  function j { new_path="$(autojump $@)"; [ -n "$new_path" ] && cd "$new_path" ; }
fi
