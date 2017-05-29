#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../setup.conf" \
    && . "../../utils.sh" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Execute ubuntu commands\n\n"
execute_commands "${UBUNTU_COMMANDS[@]}"

update
upgrade

print_in_purple "\n • APT-GET\n\n"
install_all_packages ${APT_GET_PACKAGES[@]}

print_in_purple "\n • Cleanup\n\n"
autoremove
