#!/bin/bash

lndir () {
    rm -rf $2 &> /dev/null || true
    ln -sf $1 $2
}

# pull repo
cd $source_path
git pull
cd -

#fish
echo "Linking fish config..."
ln -sf $source_path/dots/$platform/fish/config.fish $target_path/.config/fish/config.fish
ln -sf $source_path/dots/common/fish/before.init.fish $target_path/.config/fish/conf.d/before.init.fish
#omf
lndir $source_path/dots/common/omf $target_path/.config/omf
#git
echo "Linking global git config..."
ln -sf $source_path/dots/common/git/config $target_path/.config/git/config
#tmux
echo "Linking tmux config..."
ln -sf $source_path/dots/common/tmux/config $target_path/.tmux.conf
ln -sf $source_path/dots/common/tmux/config.light $target_path/.tmux.conf.light
ln -sf $source_path/dots/common/tmux/config.dark $target_path/.tmux.conf.dark
#nvim
echo "Linking nvim config..."
lndir $source_path/dots/common/nvim $target_path/.config/nvim
lndir $source_path/dots/common/vim/vim $target_path/.vim
ln -sf $source_path/dots/common/vim/vimrc $target_path/.vimrc
#gnupg-agent
ln -sf $source_path/dots/$platform/gnupg/gpg-agent.conf $target_path/.gnupg/gpg-agent.conf
#rime
echo "Linking rime config..."
if [[ "$platform" == "osx" ]]; then
    ln -sf $source_path/dots/common/rime/default.custom.yaml $target_path/Library/Rime/default.custom.yaml
    ln -sf $source_path/dots/common/rime/squirrel.custom.yaml $target_path/Library/Rime/squirrel.custom.yaml
elif [[ "$platform" == "arch" ]]; then
    ln -sf $source_path/dots/common/rime/default.custom.yaml $target_path/.config/fcitx/rime/default.custom.yaml
fi
echo ""
echo "Update complete!"
