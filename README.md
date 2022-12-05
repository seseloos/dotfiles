# Dotfiles

## tmuxinantor

- Start a new tmuxinator session with the *projects* template

```sh
tmuxinator start projects -n "${PWD##*/}" $(pwd)
```
