![devkitNix](pic.jpg)

This flake allows you to use [devkitPro](https://devkitpro.org/) toolchains in your Nix expressions.

# Usage

See the [examples](examples/) directory for complete examples working homebrew apps with nix.

# Devkitpro binary sources

devkitNix works by extracting dkp's official Docker images, patching the binaries and including everything in a single environment. Each package provides a complete toolchain including all available portlibs.

# Available Packages

## Core devkits
* devkitPPC
  * Nintendo Gamecube
  * Nintendo Wii
  * Nintendo WiiU
* devkitarm
  * Nintendo DS
* devkitA64
  * Nintendo Switch

## Libraries
* libmocha
  * Nintendo WiiU
