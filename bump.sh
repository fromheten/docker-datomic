#!/usr/bin/env bash
set -e

if [[ $# -eq 0 ]]; then
    printf "usage: $(basename $0) <version> \n";
    exit 1;
fi

sed -i '' -E -e "s/^ENV DATOMIC_VERSION (\.?[0-9]+)+/ENV DATOMIC_VERSION ${1%.*}/" Dockerfile
sed -i '' -E -e "s/quay.io\/nedap\/datomic:(\.?[0-9]+)+/quay.io\/nedap\/datomic:$1/" README.md
sed -i '' -E -e "s/datomic-pro-(\.?[0-9]+)+/datomic-pro-${1%.*}/" README.md
