{
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    ./programs/desktop/gnome.nix
    ./programs/virtualisation/podman.nix
    ./programs/office/libreoffice.nix
    ./programs/evergreens.nix
    ./services/cloud/immich/immich.nix
    ./services/cloud/nextcloud/nextcloud.nix
    ./services/cloud/paperless-ngx/paperless-ngx.nix
    ./services/network/pihole.nix
  ];
}
^