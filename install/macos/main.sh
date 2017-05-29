#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../setup.conf" \
    && . "../../utils.sh" \

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "setup macos"

copy_files_to_home "${MACOS_FILES_COPY_TO_HOME[@]}"
./osx.sh
