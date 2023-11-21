#!/bin/bash

# Requires the zip command
# zip usage: zip -r {filename.zip} {foldername}
# Script usage: bash scripts/pack.sh {foldername}

set -e

# Check the script is being run from the root of the project
if [ ! -f "./scripts/pack.sh" ]; then
    echo "Please run this script from the root of the project"
    echo "Example: bash scripts/pack.sh"
    exit 1
fi

# ====
# Create dist folder
# ====
create_dist_folder() {
    if [ -d "./dist" ]; then
        echo "Removing old dist folder"
        rm -r ./dist
    fi

    echo "Creating dist folder"
    mkdir -p ./dist
}

# ====
# Copy config file
# ====
copy_config_file() {
    echo "Generating config file"
    cp ./src/ClientArchives.con ./dist/ClientArchives.con
}

# ====
# Pack menu
# ====
pack_menu() {
    echo "Packing menu"
    cd ./src/menu
    zip -r ../../dist/menu_uncensored.zip .
    cd ../..
}

# ====
# Pack objects
# ====
pack_objects() {
    echo "Packing objects"
    cd ./src/objects
    zip -r ../../dist/objects_uncensored.zip .
    cd ../..
}

# ====
# Pack final archive
# ====
pack_final() {
    echo "Packing final archive"
    cd ./dist
    zip -r ${zip_name} .
    cd ..
}

# ====
# Copying metadata files
# ====
add_meta_files() {
    echo "Adding metadata files"
    cp LICENSE ./dist/LICENSE
    cp README.md ./dist/README.md
    cp CHANGELOG.md ./dist/CHANGELOG.md
    cp VERSION ./dist/VERSION
}

# ====
# Main function
# ====
main() {
    version=$(cat VERSION)
    zip_name="fh2_uncensored_texture_pack_${version}.zip"
    echo "Version: ${version}"

    create_dist_folder
    pack_menu
    pack_objects
    copy_config_file
    add_meta_files
    pack_final

    # if not -k or --keep-intermediate-files in args, then remove the
    # intermediate files
    if [ "$1" != "-k" ] && [ "$1" != "--keep-intermediate-files" ]; then
        echo "Removing intermediate files"
        rm ./dist/menu_uncensored.zip
        rm ./dist/objects_uncensored.zip
        rm ./dist/ClientArchives.con
        rm ./dist/VERSION
        rm ./dist/CHANGELOG.md
        rm ./dist/README.md
        rm ./dist/LICENSE
    fi

    echo "Complete! Results written to dist/${zip_name}"
}

main "@"
