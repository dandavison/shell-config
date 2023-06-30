# my-uniquify-path() {
#     typeset -A seen
#     local unique=""
#     echo $PATH | tr : ' ' | while read dir; do
#         if [[ -n $seen[$dir] ]]; then
#             continue
#         else
#             if [[ -n $unique ]]; then
#                 unique="$dir"
#             else
#                 unique="$unique:$dir"
#             fi
#             seen[$dir]=1
#         fi
#     done
#     echo $unique | tr ' ' ':'
# }

# my-uniquify-path-2() {
#     typeset -A seen
#     local unique=""
#     for dir in ${(s.:.)1}; do
#         if [[ -z $seen[$dir] ]]; then
#             continue
#         else
#             if [[ -n $unique ]]; then
#                 unique="$dir"
#             else
#                 unique="$unique:$dir"
#             fi
#             seen[$dir]=1
#         fi
#     done
#     echo $unique | tr ' ' ':'
# }

for dir in $(
    /bin/cat <<EOF
/opt/homebrew/bin
/opt/homebrew/sbin
/opt/homebrew/opt/coreutils/libexec/gnubin
/opt/homebrew/opt/gnu-sed/libexec/gnubin
/opt/homebrew/opt/postgresql/bin
$HOME/.cargo/bin
$HOME/src/emacs-config/bin
$HOME/.local/bin
$HOME/bin
EOF
); do
    [ -d $dir ] && PATH=$dir:$PATH || {
        echo "Directory doesn't exist: $dir" 1>&2
    }
done

export PATH=$PATH
