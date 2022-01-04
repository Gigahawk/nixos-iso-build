#!/bin/bash

exec 5>&1

out_path="dist/$1"

rm -rf dist
mkdir dist

echo "Starting build"

iso_path=$(nixos-generate --format-path ./install-iso-gnome.nix --configuration configuration.nix | tee >(cat - >&5))

echo "Build finished, iso written to $iso_path"

echo "Copying to $out_path"
cp "$iso_path" "$out_path"

