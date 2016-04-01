#!/bin/sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="tjkirch_mod"/' ~/.zshrc
sed -i 's/^plugins=.*/plugins=(git gitignore ruby golang node docker)/' ~/.zshrc

echo 'export GOPATH=$HOME/go' >> ~/.zshrc
echo 'export PATH=$HOME/go/bin:$PATH' >> ~/.zshrc
