FROM       ubuntu:16.04
MAINTAINER Warren Spits <warren@spits.id.au>

RUN apt-get update

RUN apt-get install -y openssh-server tmux zsh git vim
RUN apt-get install -y golang-1.6
RUN apt-get install -y golang
RUN apt-get install -y docker.io aptitude ruby2.3 ruby2.3-dev nodejs npm sudo
RUN apt-get install -y curl man-db

RUN mkdir /var/run/sshd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

RUN ln -sf /usr/share/zoneinfo/Australia/Melbourne /etc/localtime

RUN echo 'root:root' |chpasswd
RUN adduser warren --disabled-password --gecos ""
RUN usermod warren -G sudo -a
RUN echo '/bin/zsh' | chsh warren
RUN su warren -l -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'

RUN echo 'export GOPATH=$HOME/go' >> /home/warren/.zshrc && \
  echo 'PATH=$HOME/go/bin:$PATH' >> /home/warren/.zshrc && \
  sed -i 's/^ZSH_THEME=.*/ZSH_THEME="tjkirch_mod"/' /home/warren/.zshrc && \
  sed -i 's/^plugins=.*/plugins=(git gitignore ruby golang node docker)/' /home/warren/.zshrc

RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \
  cd ~/.vim/bundle && \ 
  git clone https://github.com/tpope/vim-sensible.git && \
  git clone https://github.com/fatih/vim-go.git && \
  git clone https://github.com/Shougo/neocomplete.vim.git && \
  git clone https://github.com/scrooloose/syntastic.git && \
  git clone https://github.com/scrooloose/nerdtree.git

CMD    ["/usr/sbin/sshd", "-D"]
