#!/usr/bin/env bash

NVIM_FZF="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/plugged/fzf/install"

if [ -x "${NVIM_FZF}" ]; then
  "${NVIM_FZF}" --all --no-update-rc
else
  echo "Error: Install script not found at ${NVIM_FZF}"
  exit 1
fi
