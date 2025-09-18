if status is-interactive
    # Commands to run in interactive sessions can go here
    if type -q atuin
        atuin init fish | source
    end

    if type -q $HOME/.pyenv/bin/pyenv
        fish_add_path $HOME/.pyenv/bin
        pyenv init - | source
    end
end

# user paths
fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin

# disable greeting on start up
set fish_greeting
