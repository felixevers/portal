FROM archlinux/base

RUN mkdir /home/worker

ADD ./home/ /home/worker/

RUN pacman -Syu --noconfirm
RUN pacman -Sy --noconfirm
RUN pacman -S base base-devel xorg-server xorg-xinit xorg-drivers i3-wm i3-gaps chromium git binutils neovim curl termite rofi docker docker-compose python python-pip jre-openjdk jdk-openjdk php nodejs npm maven gdb gcc cmake clang valgrind nmap netcat arp-scan zsh openssh sudo noto-fonts feh wireshark-qt irssi tor texlive-most texstudio openvpn bridge-utils easy-rsa discord arandr --noconfirm

RUN pip install requests scapy beautifulsoup4 numpy scipy matplotlib plotly pipenv tensorflow flask jupyter pandas sqlalchemy pymysql

RUN npm install -g @angular/cli ionic

RUN useradd -d /home/worker -s /bin/bash -m worker
RUN echo "worker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN chown -R worker /home/worker

RUN sudo -u worker bash -c "git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay/ && makepkg -si --noconfirm && yay -Sy polybar intellij-idea-ultimate-edition pycharm-professional android-studio android-sdk chromium-widevine typora --noconfirm --nopgpfetch"

USER worker 

CMD /usr/bin/i3
