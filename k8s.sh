#!/bin/sh

# Aliases for the common Kubernetes CLI commands.

alias k='kubectl $@'
source <(kubectl completion bash)
if [[ $(type -t compopt) = "builtin" ]]; then
    complete -o default -F __start_kubectl k
else
    complete -o default -o nospace -F __start_kubectl k
fi

alias h='helm $@'
source <(helm completion bash)
if [[ $(type -t compopt) = "builtin" ]]; then
    complete -o default -F __start_helm h
else
    complete -o default -o nospace -F __start_helm h
fi

alias kdump='kubectl get all --all-namespaces $@'
