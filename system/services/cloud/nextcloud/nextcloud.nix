{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.homelab.system.services.cloud.nextcloud;
in {
  options.homelab.system.services.cloud.nextcloud = {
    enable = lib.mkEnableOption "Nextcloud";
  };
}
