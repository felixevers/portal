docker run \
    --name PORTAL_VNC \
    --rm \
    --ipc=host \
    --privileged \
    -p 5900:5900 \
    -p 6060:6060 \
    $1
