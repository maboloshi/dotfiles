#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh" \
    && . "../setup.conf"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   pip\n\n"

    for i in "${PIP_PACKAGES[@]}"; do
        execute \
            "pip install $1" \
            "$1"
    done

}

main


