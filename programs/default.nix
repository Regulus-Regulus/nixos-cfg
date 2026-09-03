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
    ./homelab/forgejo.nix
    ./homelab/homepage.nix
    ./homelab/immich.nix
    ./homelab/keycloak.nix
    ./homelab/miniflux.nix
    ./homelab/nextcloud.nix
    ./homelab/paperless-ngx.nix
    ./homelab/pihole.nix
    ./homelab/postgresql.nix
    ./homelab/uptime-kuma.nix
  ];
}
