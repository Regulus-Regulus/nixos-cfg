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

  config = lib.mkIf cfg.enable {
    # CONFIG https://search.nixos.org/options?channel=26.05&query=nextcloud&type=options

    #
    # Optional reverse proxy through Caddy.
    #
    services.caddy = lib.mkIf cfg.proxy.enable {
      enable = true;

      virtualHosts.${cfg.proxy.hostName}.extraConfig = ''
        reverse_proxy 127.0.0.1:${toString cfg.port}
      '';
    };
  };
}
