{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.programs.homelab.paperless-ngx;
in {
  options.my.programs.homelab.paperless-ngx = {
    enable = lib.mkEnableOption "paperless-ngx";

    port = lib.mkOption {
      type = lib.types.port;
      default = 2283;
      description = "Internal port paperless-ngx listens on.";
    };

    proxy = {
      enable = lib.mkEnableOption "Expose paperless-ngx through Caddy";

      hostName = lib.mkOption {
        type = lib.types.str;
        default = "paperless-ngx.home";
        description = "Hostname used by Caddy to expose paperless-ngx.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # CONFIG https://search.nixos.org/options?channel=26.05&query=paperless&type=options#show=option%253Aservices.paperless.port
    services.paperless = {
      enable = true;
      port = cfg.port;
    };
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
