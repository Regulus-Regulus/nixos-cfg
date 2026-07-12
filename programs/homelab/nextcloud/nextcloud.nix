{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.programs.homelab.nextcloud;
in {
  options.my.programs.homelab.nextcloud = {
    enable = lib.mkEnableOption "Nextcloud";
  };
}
