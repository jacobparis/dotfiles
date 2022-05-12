#!/usr/bin/env bash

set -eu;

if test ! -v GITPOD_REPO_ROOT; then {
    printf 'error: This script is meant to be run on Gitpod, quitting...\n' && exit 1;
} fi

SOURCE_DIR="$(readlink -f "$0")" && SOURCE_DIR="${SOURCE_DIR%/*}";

cat $SOURCE_DIR/.gitconfig >> $HOME/.gitconfig;
cat $SOURCE_DIR/.zshrc >> $HOME/.zshrc;

echo "Setting zsh as the interactive shell for Gitpod task terminals"

if ! grep 'PROMPT_COMMAND=".*exec zsh"' $HOME/.bashrc 1>/dev/null; then {
    # The supervisor creates the task terminals, supervisor calls BASH from `/bin/bash` instead of the realpath `/usr/bin/bash`
    printf '%s\n' 'PROMPT_COMMAND="[ "$BASH" == /bin/bash ] && [ "$PPID" == "$(pgrep -f "supervisor run" | head -n1)" ] && test -v bash_ran && exec zsh || bash_ran=true;$PROMPT_COMMAND"' >> $HOME/.bashrc;
} fi

echo "Appending .gitpod.yml:tasks shell histories to zsh_history";

while read -r _command; do {
    if test -n "$_command"; then {
        printf '\055 cmd: %s\n  when: %s\n' "$_command" "$(date +%s)" >> "${_shell_hist_files[2]}";
    } fi 
} done < <(sed "s/\r//g" /workspace/.gitpod/cmd-* 2>/dev/null || :)
