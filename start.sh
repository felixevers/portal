read Xenv < <(x11docker --desktop --xorg --showenv)
export $Xenv
docker run \
    --env DISPLAY \
    --env XAUTHORITY \
    -v $XAUTHORITY:$XAUTHORITY \
    -v $XSOCKET:$XSOCKET \
    $1
