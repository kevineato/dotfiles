#!/usr/bin/env bash

NVIM_PLUG="${HOME}/.dotfiles/config/nvim/site/autoload/plug.vim"

if [ ! -f "${NVIM_PLUG}" ]; then
    curl -fLo "${NVIM_PLUG}" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
