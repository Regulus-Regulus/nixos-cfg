{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.programs.homelab.nextcloud;
in {
  options.my.programs.homelab.nextcloud = {
    enable = lib.mkEnableOption "nextcloud";

    port = lib.mkOption {
      type = lib.types.port;
      default = 2283;
      description = "Internal port nextcloud listens on.";
    };

    proxy = {
      enable = lib.mkEnableOption "Expose nextcloud through Caddy";

      hostName = lib.mkOption {
        type = lib.types.str;
        default = "nextcloud.home";
        description = "Hostname used by Caddy to expose nextcloud.";
      };
    };
  };

  config = lib.mkIf cfg.enable {};
}
