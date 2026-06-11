{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.system.homelab.services.cloud.nextcloud;
in {
  options.my.system.homelab.services.cloud.nextcloud = {
    enable = lib.mkEnableOption "Nextcloud";
  };
}
