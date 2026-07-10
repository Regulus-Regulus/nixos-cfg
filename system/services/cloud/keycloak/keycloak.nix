{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.system.homelab.services.cloud.keycloak;
in {
  options.my.system.homelab.services.cloud.keycloak = {
    enable = lib.mkEnableOption "Keycloak";
  };
}
