#!/usr/bin/env bash

_cwd=$(pwd)
cd ~/config/bash

source lib.sh
source env.sh
source path.sh
source prompt.sh
source completion.sh
source autojump.sh
source readline.sh
source dircolors.sh
source alias.sh
source extra.sh

cd "$_cwd"
