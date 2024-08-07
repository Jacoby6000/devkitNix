#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nix-prefetch-docker nix-prefetch-github
# shellcheck shell=bash

# if $1 is set, only fetch that dependency

SELECTIVE_UPDATE=$1

function fetch_docker() {
  if [[ -n $SELECTIVE_UPDATE && $SELECTIVE_UPDATE != $1 ]]; then
    return
  fi

  echo "Fetching devkitpro/$1 from docker"

  cp "sources/$1.json" "sources/$1.json.old"
  nix-prefetch-docker --image-name "devkitpro/$1" --json --quiet > "sources/$1.json"
  diff -u "sources/$1.json" "sources/$1.json.old"
}

function fetch_github() {
  OWNER=$1
  REPONAME=$2
  REV=$3

  if [[ -n $SELECTIVE_UPDATE && $SELECTIVE_UPDATE != $REPONAME ]]; then
    return
  fi

  # if rev is set add it to the command
  if [[ -z $REV ]]; then
    echo "Fetching $OWNER/$REPONAME from github"
    nix-prefetch-github --quiet --json $OWNER $REPONAME > "sources/$REPONAME.json"
  else 
    echo "Fetching $OWNER/$REPONAME $REV from github"
    nix-prefetch-github --quiet --json --rev $REV $OWNER $REPONAME > "sources/$REPONAME.json"
  fi


  cp "sources/$REPONAME.json" "sources/$REPONAME.json.old"
  diff -u "sources/$REPONAME.json" "sources/$REPONAME.json.old"
}

mkdir -p sources

fetch_docker devkitarm
fetch_docker devkita64
fetch_docker devkitppc
fetch_github wiiu-env libmocha

rm -f sources/*.json.old
