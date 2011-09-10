#!/usr/bin/env bash

source ~/lib/bash/autojump

# Redefine autojump's j so as not to echo the new location
function j { new_path="$(autojump $@)"; [ -n "$new_path" ] && cd "$new_path" ; }
