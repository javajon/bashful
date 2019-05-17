#!/bin/sh

# Aliases for the common Ansible CLI commands, but instead of headaches with a local install, have the commands run from a container.
# Prerequisite: Docker must be installed
# Usage: cansible ansible-playbook -u playbook.yml
# cansible = containerized ansible

# You can put these inside your dotfiles (~/.bashrc or ~/.zshrc to make handy aliases).
# When adding these aliases to shell be sure to source them with the prefix `. `: Run `. ./[this script name].sh`

alias cansible='docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/.ssh/id_rsa --workdir=/ansible willhallonline/ansible:2.7-alpine '