{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.programs.homelab.keycloak;
in {
  options.my.programs.homelab.keycloak = {
    enable = lib.mkEnableOption "Keycloak";
  };
}
