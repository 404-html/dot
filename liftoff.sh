#!/bin/bash

# output format functions
pfinfo () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

pfwarn () {
  printf "\r  [ \033[00;33mN.B.\033[0m ] $1\n"
}

pfuser () {
  printf "\r  [ \033[0;36m??\033[0m ] $1\n"
}

pfsuccess () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

pffail () {
  printf "\r\033[2K  [\033[0;31mpffail\033[0m] $1\n"
  exit
}

cat << EOF

^^^^^^^^^^^^^^^^^^^^
READY FOR .LIFTOFF!?
Yo tambien, $OSTYPE.
Let's get .filed up!
~~~~~~~~~~~~~~~~~~~~

EOF

# First, have a homebrew
if ! type -f brew && [[ "$OSTYPE" == "darwin"* ]]; then
    pfinfo 'Installing homebrew...'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    pfinfo "Updating homebrew..."
    brew update
fi

pfinfo "Installing git and bash-completion..."
brew install git bash-completion

GIT_VERSION=`git --version | awk '{print $3}'`

URL="https://raw.githubusercontent.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash"
pfinfo "Downloading git-completion@v$GIT_VERSION..."
$(curl "$URL" --silent --output "$HOME/.git-completion.bash") || pffail "Couldn't download completion script."

PROMPT_URL="https://raw.githubusercontent.com/git/git/v$GIT_VERSION/contrib/completion/git-prompt.sh"
pfinfo "Downloading git-prompt@v$GIT_VERSION..."
$(curl "$PROMPT_URL" --silent --output "$HOME/.git-prompt.sh") || pffail "Couldn't download prompt  script."

DOT_DIR="$HOME/.dotfiles"
# backup current dotfiles
if [[ -d $DOT_DIR ]] ; then
    pfwarn "existing dotfiles found"
    now="$(date '+%Y%m%d%H%M')"
    pfinfo "Backing up old dotfiles in ~/.dotfiles_$now"
    mv "$DOT_DIR" "${DOT_DIR}_${now}"
fi

# clone fresh dotfiles
pfinfo "cloning krry's dotfiles to $DOT_DIR"
git clone https://github.com/krry/dot.git $DOT_DIR
pfinfo "importing submodules"
cd $DOT_DIR
git submodule init
git submodule update --remote
pfinfo "Installing krry's dotfiles"
$DOT_DIR/bootstrap
