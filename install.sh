#!/bin/bash
set -x

DOT_DIRECTORY="${HOME}/dotfiles"
REMOTE_URL="https://github.com/aha-oretama/dotfiles.git"

usage() {
  name=`basename $0`
  cat <<EOF
Usage:
  $name [arguments]
Arguments:
  -f $(tput setaf 1)** warning **$(tput sgr0) Overwrite dotfiles which exists from the beginning.
  -h Print help (this message)
EOF
  exit 0
}

while getopts fh opt
do
  case ${opt} in
    f)
      OVERWRITE=true
      ;;
    h)
      usage
      ;;
  esac
done
shift $((OPTIND - 1))

link_files() {
  # If missing, download and extract the dotfiles repository
  echo "Downloading dotfiles..."
  rm -Rf ${DOT_DIRECTORY}

  if [[ "$(which git && git --version)" ]]; then
    git clone --recursive "${REMOTE_URL}" "${DOT_DIRECTORY}"
  else
    echo "$(tput setaf 1)Must install git. You can install by using install.sh ︎$(tput sgr0)"
    exit 1;
  fi

  echo "$(tput setaf 2)Download dotfiles complete!. ✔︎$(tput sgr0)"
  cd ${DOT_DIRECTORY}

  for f in .??*
  do
    # Force remove the vim directory if it's already there
    [ -n "${OVERWRITE}" -a -e ${HOME}/${f} ] && rm -f ${HOME}/${f}
    if [[ ! -e ${HOME}/${f} ]]; then
      # If you have ignore files, add file/directory name here
      [[ ${f} == ".git" ]] && continue
      [[ ${f} == ".gitignore" ]] && continue
      [[ ${f} == ".DS_Store" ]] && continue
      ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
    fi
  done

  echo "$(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)"
}

link_files
