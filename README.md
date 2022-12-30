# Dotfiles for kneilb

Some basic configuration to keep me sane when setting up a new machine.

## Quickstart

```
mkdir -p ~/.local/bin
source ~/.profile
cd ~/.local

sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init --apply --ssh kneilb
```

