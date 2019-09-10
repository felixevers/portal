FROM archlinux/base

RUN mkdir /home/worker

ADD ./.bashrc /home/worker/
ADD ./.config/ /home/worker/

RUN pacman -Syu --noconfirm
RUN pacman -Sy --noconfirm
RUN pacman -S base base-devel xorg-server xorg-xinit xorg-drivers i3-wm i3-gaps chromium git zsh base binutils neovim curl termite rofi docker docker-compose python python-pip jre-openjdk jdk-openjdk php nodejs npm maven gdb gcc cmake clang valgrind nmap netcat arp-scan zsh openssh sudo --noconfirm

RUN pip install pipenv tensorflow flask jupyter pandas sqlalchemy pymysql

RUN npm install -g @angular/cli ionic

RUN useradd -d /home/worker -m worker
RUN groupadd sudo
RUN usermod -aG sudo worker
USER worker

CMD /usr/bin/i3
