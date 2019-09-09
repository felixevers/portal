read Xenv < <(x11docker --desktop --xorg --wm=none --vt=$2 --showenv)
export $Xenv
docker run \
    --env DISPLAY \
    --env XAUTHORITY \
    -v $XAUTHORITY:$XAUTHORITY \
    -v $XSOCKET:$XSOCKET \
    $1
