#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nix-prefetch-docker nix-prefetch-git
# shellcheck shell=bash

# if $1 is set, only fetch that dependency

SELECTIVE_UPDATE=$1

function fetch_docker() {
  if [[ -n $SELECTIVE_UPDATE && $SELECTIVE_UPDATE != $1 ]]; then
    return
  fi

  echo "Fetching devkitpro/$1"

  cp "sources/$1.json" "sources/$1.json.old"
  nix-prefetch-docker --image-name "devkitpro/$1" --json --quiet > "sources/$1.json"
  diff -u "sources/$1.json" "sources/$1.json.old"
}

function fetch_github() {
  if [[ -n $SELECTIVE_UPDATE && $SELECTIVE_UPDATE != $2 ]]; then
    return
  fi

  ORG=$1
  REPO=$2
  URL="https://github.com/$ORG/$REPO"

  echo "Fetching $URL"

  cp "sources/$2.json" "sources/$2.json.old"
  nix-prefetch-git --quiet $URL > "sources/$2.json"
  diff -u "sources/$2.json" "sources/$2.json.old"
}

mkdir -p sources

fetch_docker devkitarm
fetch_docker devkita64
fetch_docker devkitppc
fetch_github wiiu-env libmocha

rm -f sources/*.json.old
