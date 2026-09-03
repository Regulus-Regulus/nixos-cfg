{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.programs.homelab.forgejo;
in {
  options.my.programs.homelab.forgejo = {
    enable = lib.mkEnableOption "forgejo";

    port = lib.mkOption {
      type = lib.types.port;
      default = 3000;
      description = "Internal port forgejo listens on.";
    };

    proxy = {
      enable = lib.mkEnableOption "Expose forgejo through Caddy";

      hostName = lib.mkOption {
        type = lib.types.str;
        default = "forgejo.home";
        description = "Hostname used by Caddy to expose forgejo.";
      };
    };
  };

  config = lib.mkIf cfg.enable {


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
