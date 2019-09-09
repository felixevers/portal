FROM archlinux/base

RUN pacman -Syu --noconfirm
RUN pacman -Sy --noconfirm
RUN pacman -S base base-devel xorg-server xorg-xinit xorg-drivers i3-wm chromium git sudo zsh base binutils neovim curl termite rofi docker docker-compose python python-pip jre-openjdk jdk-openjdk php nodejs npm maven gdb gcc cmake clang valgrind nmap netcat arp-scan zsh openssh --noconfirm

#RUN yay -Sy polybar intellij-idea-ultimate-edition pycharm-professional android-studio android-sdk android-sdk-platform-tools android-sdk-build-tools android-tools flutter --noconfirm

RUN pip install pipenv tensorflow flask jupyter pandas sqlalchemy pymysql

RUN npm install -g @angular/cli ionic

RUN docker pull python:3.7-alpine
RUN docker pull mariadb:latest
RUN docker pull phpmyadmin:latest
RUN docker pull archlinux/base:latest

RUN echo "exec i3" > ~/.xinitrc

CMD /usr/bin/startx
