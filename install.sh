#!/bin/sh

set -e
#set -x

#link files
for item in `find $PWD -maxdepth 1 -mindepth 1 -type f \( ! -iname "install.sh" ! -iname "README.markdown" \) -printf "%P\n"`;do
    ln -snf "$PWD/$item" "$HOME/.$item"
done

#process .config
for item in `find "$PWD/config" -maxdepth 1 -mindepth 1 -printf "%P\n"`;do
    ln -snf "$PWD/config/$item" "$HOME/.config/$item"
done

#process .vim
for item in `find "$PWD/vim" -maxdepth 1 -mindepth 1 -printf "%P\n"`;do
    ln -snf "$PWD/vim/$item" "$HOME/.vim/$item"
done

#solarized-task
ln -snf "$PWD/solarized-task" "$HOME/.solarized-task"

#bin
ln -snf "$PWD/bin" "$HOME/bin"

#cmus
ln -snf "$PWD/cmus" "$HOME/.cmus"

#change login shell to zsh
if ! grep -q "^$USER:.*zsh$" /etc/passwd; then
    echo "Changing login shell for $USER to zsh ..."
    chsh -s `which zsh`
fi
