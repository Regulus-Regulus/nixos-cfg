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
    ./homelab/immich.nix
    ./homelab/nextcloud.nix
    ./homelab/paperless-ngx.nix
    ./homelab/pihole.nix
    ./homelab/forgejo.nix
    ./homelab/homepage.nix
    ./homelab/keycloak.nix
    ./homelab/nextcloud.nix
    ./homelab/uptime-kuma.nix
    ./homelab/postgresql.nix
    ./homelab/redis.nix
  ];
}
