#!/bin/sh

# Aliases for the common Ansible CLI commands, but instead of headaches with a local install, have the commands run from a container.

# Prerequisite is docker must be installed.
# When adding these aliases to shell be sure to source them with the prefix `. `: Run `. ./[this script name].sh`

alias          ansible='docker run -v "$(pwd):/app" -w "/app" -it --rm ansible/ubuntu14.04-ansible ansible --private-key=.ssh/id_rsa'
alias ansible-playbook='docker run -v "$(pwd):/app" -w "/app" -it --rm ansible/ubuntu14.04-ansible ansible-playbook --private-key=.ssh/id_rsa'
alias    ansible-shell='docker run -v "$(pwd):/app" -w "/app" -it --rm ansible/ubuntu14.04-ansible bash'
