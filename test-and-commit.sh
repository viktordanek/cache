#!/bin/sh

date &&
echo AA &&
nix flake check &&
WORK=$( mktemp -d ) &&
echo WORK=${WORK} &&
echo BB &&
export ARCHIVE=$(mktemp -d ${WORK}/XXXXXXXX) && export RESOURCES=$(mktemp -d ${WORK}/XXXXXXXX) && time nix run .#0-0-0 &&
echo CC &&
export ARCHIVE=$(mktemp -d ${WORK}/XXXXXXXX) && export RESOURCES=$(mktemp -d ${WORK}/XXXXXXXX) && time nix run .#0-0-1 &&
echo DD &&
export ARCHIVE=$(mktemp -d ${WORK}/XXXXXXXX) && export RESOURCES=$(mktemp -d ${WORK}/XXXXXXXX) && time nix run .#0-1-0 &&
echo EE &&
export ARCHIVE=$(mktemp -d ${WORK}/XXXXXXXX) && export RESOURCES=$(mktemp -d ${WORK}/XXXXXXXX) && time nix run .#0-1-1 &&
echo FF &&
export ARCHIVE=$(mktemp -d ${WORK}/XXXXXXXX) && export RESOURCES=$(mktemp -d ${WORK}/XXXXXXXX) && time nix run .#1-0-0 &&
echo GG &&
export ARCHIVE=$(mktemp -d ${WORK}/XXXXXXXX) && export RESOURCES=$(mktemp -d ${WORK}/XXXXXXXX) && time nix run .#1-0-1 &&
echo HH &&
export ARCHIVE=$(mktemp -d ${WORK}/XXXXXXXX) && export RESOURCES=$(mktemp -d ${WORK}/XXXXXXXX) && time nix run .#1-1-0 &&
echo II &&
export ARCHIVE=$(mktemp -d ${WORK}/XXXXXXXX) && export RESOURCES=$(mktemp -d ${WORK}/XXXXXXXX) && time nix run .#1-1-1 &&
date &&
echo AFTER &&
git commit -am "cache/test-and-commit ${@}"