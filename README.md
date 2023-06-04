# NixOS

My own NixOS setup.

First clone from nomadics9/NixOS-Flake



nix develop --extra-experimental-features nix-command --extra-experimental-features flakes


nix flake update


sudo nixos-rebuild switch --flake .#kourosh