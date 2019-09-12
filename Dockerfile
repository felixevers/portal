FROM archlinux/base

RUN mkdir /home/worker

ADD ./home/ /home/worker/

RUN pacman -Syu --noconfirm
RUN pacman -Sy --noconfirm
RUN pacman -S base base-devel xorg-server xorg-xinit xorg-drivers i3-wm i3-gaps binutils chromium git neovim curl termite rofi python python-pip jre-openjdk jdk-openjdk php nodejs npm sudo noto-fonts feh arandr --noconfirm

RUN useradd -d /home/worker -s /bin/bash -m worker
RUN echo "worker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN chown -R worker /home/worker

RUN sudo -u worker bash -c "git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay/ && makepkg -si --noconfirm && yay -Sy polybar chromium-widevine ttf-material-icons-git --noconfirm --nopgpfetch"

USER worker

CMD /usr/bin/i3
