{
  self,
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.my.programs.homelab.miniflux;
in {
  options.my.programs.homelab.miniflux = {
    enable = lib.mkEnableOption "Miniflux";
    port = lib.mkOption {
      type = lib.types.port;
      default = 8080;
      description = "Internal port Miniflux listens on.";
    };
    proxy = {
      enable = lib.mkEnableOption "Expose Miniflux through Caddy";

      hostName = lib.mkOption {
        type = lib.types.str;
        default = "miniflux.home";
        description = "Hostname used by Caddy to expose Miniflux.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    #
    # Miniflux application configuration.
    #
    # Database creation is handled by our shared PostgreSQL module instead of
    # the Miniflux NixOS module. This keeps all database management in one
    # place.
    #
    services.miniflux = {
      enable = true;
      createDatabaseLocally = false;

      config = {
        BASE_URL =
          if cfg.proxy.enable
          then "https://${cfg.proxy.hostName}"
          else "http://127.0.0.1:${toString cfg.port}";
        LISTEN_ADDR = "127.0.0.1:${toString cfg.port}";

        # TODO
        # Keycloak as SSO
        # OAUTH2_CLIENT_ID =
        # OAUTH2_CLIENT_SECRET
        # OAUTH2_CLIENT_SECRET_FILE
        # OAUTH2_OIDC_DISCOVERY_ENDPOINT
        # OAUTH2_PROVIDER
        # OAUTH2_REDIRECT_URL
        # OAUTH2 should be able to create users
        OAUTH2_USER_CREATION = 1;
        OAUTH2_OIDC_PROVIDER_NAME = "Keycloak";
        DATABASE_URL = "postgres://miniflux@/miniflux?host=/run/postgresql";
      };
    };

    #
    # Ensure our shared PostgreSQL module is enabled and provisions the
    # database required by Miniflux.
    #
    my.programs.homelab.postgresql.enable = true;
    my.programs.homelab.postgresql.databases = [
      {
        name = "miniflux";
      }
    ];

    #
    # Optional reverse proxy through Caddy.
    #
    services.caddy = mkIf cfg.proxy.enable {
      enable = true;

      virtualHosts.${cfg.proxy.hostName}.extraConfig = ''
        reverse_proxy 127.0.0.1:${toString cfg.port}
      '';
    };

    # Reference:
    # https://search.nixos.org/options?channel=26.05&query=miniflux#show=option%253Aservices.miniflux.enable
  };
}
