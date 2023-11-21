#!/bin/bash

# This script is used to generate the version string for the project.

set -e

# Check the script is being run from the root of the project
if [ ! -f "./scripts/version.sh" ]; then
    echo "Please run this script from the root of the project"
    echo "Example: bash scripts/version.sh"
    exit 1
fi


# ====
# Read version from args
# ====
parse_args() {

    if [ $# -eq 0 ]; then
        echo "Provide a version number"
        echo "Example: bash scripts/version.sh 2.63.0"
        exit 1
    fi

    # Check the version number is valid
    if [[ ! $1 =~ ^[0-9]+\.[0-9][0-9]\.[0-9]+$ ]]; then
        echo "Invalid version number"
        echo "Example: bash scripts/version.sh 2.63.0"
        exit 1
    fi

    version="v$1"
}


# ====
# Main function
# ====
main() {
    parse_args "$@"

    echo "Version: ${version}"
    echo "$version" > VERSION
    echo "{ \"ref\": \"refs/tags/${version}\" }" > ./.github/workflows/tag.json
    echo "Complete! Version bumped to ${version}"
}


main "$@"
