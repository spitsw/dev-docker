FROM       ubuntu:16.04
MAINTAINER Warren Spits <warren@spits.id.au>

RUN sed -ie 's/archive\.ubuntu\.com/mirror.aarnet.edu.au\/pub\/ubuntu\/archive/' /etc/apt/sources.list
RUN rm -rf /var/lib/apt/lists/* && apt-get update

RUN apt-get install -y xz-utils
RUN apt-get install -y openssh-server tmux zsh git curl man-db sudo iputils-ping
RUN apt-get install -y aptitude software-properties-common
RUN apt-get install -y docker.io ruby2.3 ruby2.3-dev nodejs npm python3-pip python3
RUN apt-get install -y golang golang-go.tools golang-1.6
RUN apt-get install -y mosh

COPY ca-certificates/ /usr/local/share/ca-certificates/
RUN update-ca-certificates

RUN add-apt-repository ppa:neovim-ppa/unstable && \
  apt-get update && apt-get install -y neovim
RUN update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60 && \
  update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60 && \
  update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

RUN mkdir /var/run/sshd
EXPOSE 22

RUN ln -sf /usr/share/zoneinfo/Australia/Melbourne /etc/localtime

COPY locale.gen /etc/
RUN locale-gen
RUN update-locale LANG=en_AU.UTF-8

RUN adduser warren --disabled-password --shell /bin/zsh --gecos "" && \
  usermod warren -G sudo,users -a && \
  passwd -d warren

COPY home/ /home/warren/
RUN chown -R warren:warren /home/warren

USER warren

# Install oh-my-zsh
RUN umask g-w,o-w;git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
RUN cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
RUN sed -i 's/^ZSH_THEME=.*/ZSH_THEME="tjkirch_mod"/' ~/.zshrc
RUN sed -i 's/^plugins=.*/plugins=(git gitignore ruby golang node docker)/' ~/.zshrc

RUN pip3 install setuptools
RUN pip3 install neovim

RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ARG GOPATH=/home/warren/go
RUN echo export GOPATH=$GOPATH >> ~/.zshrc
RUN echo export PATH=\$GOPATH/bin:\$PATH >> ~/.zshrc
RUN git clone https://github.com/9fans/go.git $GOPATH/src/9fans.net/go
RUN go get -v github.com/nsf/gocode \
            github.com/alecthomas/gometalinter \
            golang.org/x/tools/cmd/goimports \
            github.com/rogpeppe/godef \
            golang.org/x/tools/cmd/oracle \
            golang.org/x/tools/cmd/gorename \
            github.com/golang/lint/golint \
            github.com/kisielk/errcheck \
            github.com/jstemmer/gotags \
            github.com/klauspost/asmfmt/cmd/asmfmt \
            github.com/fatih/motion

#RUN nvim -c 'PlugInstall' -c 'UpdateRemotePlugins' -c 'qa!'

USER root
CMD    ["/usr/sbin/sshd", "-D"]
