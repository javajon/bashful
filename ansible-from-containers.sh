#!/bin/sh

# Aliases for the common Ansible CLI commands, but instead of headaches with a local install, have the commands run from a container.
# Prerequisite: Docker must be installed
# Usage: cansible ansible-playbook -u playbook.yml
#        cansible /bin/sh    (to ssh into container)
# cansible = containerized ansible

# You can put these inside your dotfiles (~/.bashrc or ~/.zshrc to make handy aliases).
# When adding these aliases to shell be sure to source it:
#  example 1: `source <(wget -q -O- https://raw.githubusercontent.com/javajon/bashful/master/ansible-from-containers.sh)`
#  example 2: `. ./ansible-from-containers.sh`

alias     cansible='docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/.ssh/id_rsa --workdir=/ansible ansible/ansible-runner:1.3.4'
alias ansible-lint='docker run --rm -it -v ${PWD}:/mnt:ro haxorof/ansible-lint'