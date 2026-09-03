{
  self,
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.my.programs.homelab.immich;
in {
  options.my.programs.homelab.immich = {
    enable = lib.mkEnableOption "Immich";

    port = lib.mkOption {
      type = lib.types.port;
      default = 2283;
      description = "Internal port Immich listens on.";
    };

    mediaLocation = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/immich";
      description = "Location for Immich uploaded media.";
    };

    proxy = {
      enable = lib.mkEnableOption "Expose Immich through Caddy";

      hostName = lib.mkOption {
        type = lib.types.str;
        default = "immich.home";
        description = "Hostname used by Caddy to expose Immich.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    #
    # Immich application configuration.
    #
    # PostgreSQL and Database creation is handled by the shared PostgreSQL module.
    # Immich manages its own Redis.
    #
    # Reference:
    # https://search.nixos.org/options?channel=26.05&query=immich
    services.redis.servers.immich.logLevel = "warning";
    services.immich = {
      enable = true;

      # TODO
      # Settings for immich here

      # Keep Immich bound locally.
      # External access is handled by Caddy.
      #

      externalDomain = "https://${config.hostName}";
      host = "127.0.0.1";
      port = cfg.port;

      #
      # Persistent storage for uploaded photos/videos.
      #
      mediaLocation = cfg.mediaLocation;

      #
      # We manage PostgreSQL centrally.
      #
      database = {
        host = "/run/postgresql";
        enable = false;
        createDB = false;
      };
    };

    #
    # Ensure shared PostgreSQL module provisions Immich database.
    #
    my.programs.homelab.postgresql.enable = true;
    my.programs.homelab.postgresql.databases = [
      {
        name = "immich";
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

    #
    # Persistent directories.
    #
    systemd.tmpfiles.rules = [
      "d ${cfg.mediaLocation} 0755 immich immich -"
    ];
  };
}
