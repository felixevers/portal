FROM useto/portal:latest

RUN sudo pacman -Sy --noconfirm
RUN sudo pacman -S xorg-server xorg-server-xvfb x11vnc --noconfirm

RUN sudo -u worker bash -c "yay -Sy novnc websockify --noconfirm --nopgpfetch"

ENV DISPLAY :0

CMD Xvfb :0 -ac -listen tcp -screen 0 1920x1080x24 & i3 & x11vnc -nopw -forever -display :0 -multiptr & novnc --listen 6060 --vnc localhost:5900
