#!/bin/bash

exec 5>&1


echo "Starting build"

out=$(nixos-generate --format-path ./install-iso-gnome.nix --configuration configuration.nix | tee >(cat - >&5))

echo "Build finished"

echo "$out"
