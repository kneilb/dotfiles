if status is-interactive
    # Commands to run in interactive sessions can go here
    if type -q atuin
        atuin init fish | source
    end

    if type -q $HOME/.pyenv/bin/pyenv
        fish_add_path $HOME/.pyenv/bin
        pyenv init - | source
    end

    if type -q mise
       mise activate fish | source
    end
end

# user paths
fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.opencode/bin

# user variables
set -x KUBECONFIG $HOME/.kube/config:$HOME/.kube/kind-mkio-config:$HOME/.kube/az-aks-config:$HOME/.kube/aws-eks-config

# disable greeting on start up
set fish_greeting
