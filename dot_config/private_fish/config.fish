if status is-interactive
    # Commands to run in interactive sessions can go here
end

# user paths
fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin

# disable greeting on start up
set fish_greeting