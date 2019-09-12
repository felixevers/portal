read Xenv < <(x11docker --desktop --xorg --wm=none --vt=$2 --quiet --showenv)
export $Xenv
docker run \
    --env DISPLAY \
    --env XAUTHORITY \
    -v $XAUTHORITY:$XAUTHORITY \
    -v $XSOCKET:$XSOCKET \
    --rm \
    -v /dev:/dev \
    --ipc=host \
    --privileged \
    -d \
    $1
