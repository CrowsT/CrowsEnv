function sync_system
    title "sync system"
    if test $os = archlinux
        update_archlinux
        install_archlinux
    else if test $os = macos
        update_macos
        install_macos
    end
end

function install_archlinux
    pacman_install go tree
    if not type -q yay
        gitget "~/Projects/aur.archlinux.org/yay"
        makepkg -si --noconfirm
        cd -
    end
    yay_install direnv
end

function install_macos
    brew_install make go tree direnv gnu-sed
end

function update_archlinux
    #TODO: update mirror list
    yay -Syu
end

function update_macos
    brew update && brew upgrade && brew cleanup
    brew upgrade --cask
end
