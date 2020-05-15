#!/usr/bin/env bash

fonts_dir="${HOME}/.local/share/fonts"
if [ ! -d "${fonts_dir}" ]; then
  echo "mkdir -p $fonts_dir"
  mkdir -p "${fonts_dir}"
else
  echo "Found fonts dir $fonts_dir"
fi

for type in Bold Light Medium Regular Retina; do
  file_path="${HOME}/.local/share/fonts/FiraCode-Nerd-Font-${type}.ttf"
  file_url="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/${type}/complete/Fira%20Code%20${type}%20Nerd%20Font%20Complete.ttf?raw=true"
  if [ ! -e "${file_path}" ]; then
    echo "wget -O $file_path $file_url"
    wget -O "${file_path}" "${file_url}"
  else
    echo "Found existing file $file_path"
  fi;
done

echo "fc-cache -f"
fc-cache -f
