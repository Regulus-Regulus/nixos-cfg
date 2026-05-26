{
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    ./programs/desktop/gnome.nix
    ./programs/virtualisation/podman.nix
    ./programs/evergreens.nix
    ./services/cloud/immich.nix
    ./services/network/pihole.nix
  ];
}
