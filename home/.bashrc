alias vim="nvim"
alias l="ls -lahs"
alias ..="cd .."
alias public="curl https://api.ipify.org/ && echo"

for f in "$HOME/.bash/"*?.bash; do
    . "$f"
done
