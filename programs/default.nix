{
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    ./system/desktop/gnome.nix
    ./system/virtualisation/podman.nix
    ./system/office/libreoffice.nix
    ./system/evergreens.nix
    ./homelab/immich/immich.nix
    ./homelab/nextcloud/nextcloud.nix
    ./homelab/paperless-ngx/paperless-ngx.nix
    ./homelab/pihole.nix
  ];
}
