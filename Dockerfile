FROM       ubuntu:16.04
MAINTAINER Warren Spits <warren@spits.id.au>

#RUN sed -ie 's/archive\.ubuntu\.com/ftp.iinet.net.au\/pub/' /etc/apt/sources.list
RUN rm -rf /var/lib/apt/lists/* && apt-get update

RUN apt-get install -y xz-utils
RUN apt-get install -y openssh-server tmux zsh git curl man-db sudo iputils-ping
RUN apt-get install -y aptitude software-properties-common
RUN apt-get install -y docker.io ruby2.3 ruby2.3-dev nodejs npm python3-pip python3
RUN apt-get install -y golang golang-1.6

COPY ca-certificates/ /usr/local/share/ca-certificates/
RUN update-ca-certificates

RUN add-apt-repository ppa:neovim-ppa/unstable && \
  apt-get update && apt-get install -y neovim
RUN update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60 && \
  update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60 && \
  update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

RUN mkdir /var/run/sshd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
EXPOSE 22

RUN ln -sf /usr/share/zoneinfo/Australia/Melbourne /etc/localtime

RUN adduser warren --disabled-password --shell /bin/zsh --gecos "" && \
  usermod warren -G sudo,users -a && \
  passwd -d warren

COPY home/ /home/warren/
RUN chown -R warren:warren /home/warren

USER warren

RUN pip3 install setuptools
RUN pip3 install neovim

RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ENV NVIM_TUI_ENABLE_TRUE_COLOR=1
ENV LANG=en_AU.UTF-8
#RUN nvim -c 'PlugInstall' -c 'UpdateRemotePlugins' -c 'qa!'
#RUN nvim +GoInstallBinaries +qall

USER root
CMD    ["/usr/sbin/sshd", "-D"]
