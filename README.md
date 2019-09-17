# portal
A tool for setups with dockerized workspaces

## Installation

All you need to get started is `docker`, `xorg` and `bash`.

After that you have to clone this repository: `git clone https://github.com/use-to/portal`

Thats it!

## Example

To run your own dockerized workspace use the following command:

`bash start.sh useto/portal 2`

- [`bash`](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) - unix shell

- [`start.sh`](https://github.com/use-to/portal/blob/master/start.sh)  - startup script

- [`useto/portal`](https://hub.docker.com/r/useto/portal) - minimal testing image with i3, rofi and polybar
- `2` - [vt](https://en.wikipedia.org/wiki/Virtual_console) number

Make sure you run this script with the right permissions. Maybe you have to use:

`sudo bash start.sh useto/portal 2`

## Configuration

Use the [`run`](https://github.com/use-to/portal/blob/master/run) directory to execute some scripts on startup.

## Exiting

You can switch your [virtual console](https://en.wikipedia.org/wiki/Virtual_console) with `CTRL`+`ALT`+`FX`. The `X` is for example `1` for `tty1`.

After that you can delete your workspace by running the [stop](https://github.com/use-to/portal/blob/master/stop.sh) script with the right permissions:

`bash stop.sh 2`

## Persistence

The tool creates a persistent directory on the host (`~/portal_data`) and mounts it into the workspace (`~/data`).

If you want to keep some changes like installed packages you can commit your running container into an image:

`bash commit.sh 2 portal_commit`
