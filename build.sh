#!/bin/bash

exec 5>&1

outpath="dist/$1"

rm -rf dist
mkdir dist

echo "Starting build"

out=$(nixos-generate --format-path ./install-iso-gnome.nix --configuration configuration.nix | tee >(cat - >&5))

echo "Build finished, iso written to $out"

echo "Copying to $outpath"
cp "$1" "$outpath"

