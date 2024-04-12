{ config, lib, pkgs,
  inputs,
  ... }:
{
  imports = [
    ./hardware-configuration.nix

    inputs.nixos-hardware.nixosModules.framework-13-7040-amd

    ./disko.nix
    inputs.disko.nixosModules.disko

    ./configuration.nix
  ];
}
