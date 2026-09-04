{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.programs.homelab.homepage;
in {
  options.my.programs.homelab.homepage = {
    enable = lib.mkEnableOption "homepage";

    port = lib.mkOption {
      type = lib.types.port;
      default = 8082;
      description = "Internal port homepage listens on.";
    };

    proxy = {
      enable = lib.mkEnableOption "Expose homepage through Caddy";

      hostName = lib.mkOption {
        type = lib.types.str;
        default = "homepage.home";
        description = "Hostname used by Caddy to expose homepage.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.homepage-dashboard = {
      enable = true;
    };
    # CONFIG TODO
    # https://search.nixos.org/options?channel=26.05&query=homepage-dashboard&type=options#show=option%253Aservices.homepage-dashboard.listenPort
    #
    # Optional reverse proxy through Caddy.
    #
    services.caddy = mkIf cfg.proxy.enable {
      enable = true;

      virtualHosts.${cfg.proxy.hostName}.extraConfig = ''
        reverse_proxy 127.0.0.1:${toString cfg.port}
      '';
    };
  };
}
