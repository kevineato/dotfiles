#!/usr/bin/env bash

NVIM_PLUG="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
VIM_PLUG="${HOME}/.vim/autoload/plug.vim"

if [ ! -f "${NVIM_PLUG}" ]; then
  curl -fLo "${NVIM_PLUG}" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -f "${VIM_PLUG}" ]; then
  cp "${NVIM_PLUG}" "${VIM_PLUG}"
fi
