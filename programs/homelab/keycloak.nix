{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.programs.homelab.keycloak;
in {
  options.my.programs.homelab.keycloak = {
    enable = lib.mkEnableOption "keycloak";

    port = lib.mkOption {
      type = lib.types.port;
      default = 8080;
      description = "Internal port keycloak listens on.";
    };

    proxy = {
      enable = lib.mkEnableOption "Expose keycloak through Caddy";

      hostName = lib.mkOption {
        type = lib.types.str;
        default = "keycloak.home";
        description = "Hostname used by Caddy to expose keycloak.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
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
