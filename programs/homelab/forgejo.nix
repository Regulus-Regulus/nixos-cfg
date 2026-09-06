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

  # TODO
  # Declarative Users, requries SOPS
  # Add Email Support
  # Adding Runners
  # See: https://wiki.nixos.org/wiki/Forgejo

  config = lib.mkIf cfg.enable {
    #
    # Forgejo application configuration.
    #
    # PostgreSQL and Database creation is handled by the shared PostgreSQL module.
    #
    # Reference:
    # https://search.nixos.org/options?channel=26.05&query=forgejo
    services.forgejo = {
      enable = true;
      database = {
        type = "postgres";
        createDatabase = false;
        name = "forgejo";
        user = "forgejo";
        socket = "/run/postgresql";
      };
      # Enable Git Large File Storage
      lfs.enable = true;
      settings = {
        server = {
          DOMAIN = "${cfg.proxy.hostName}";
          ROOT_URL = "https://${cfg.proxy.hostName}/";
          HTTP_PORT = cfg.port;
          SSH_PORT = lib.head config.services.openssh.ports;
        };
        service.DISABLE_REGISTRATION = true;
      };
    };
    #
    # Ensure shared PostgreSQL module provisions Forgejo database.
    #
    my.programs.homelab.postgresql = {
      enable = true;
      databases = [
        {
          name = "forgejo";
        }
      ];
    };

    #
    # Optional reverse proxy through Caddy.
    #
    services.caddy = lib.mkIf cfg.proxy.enable {
      enable = true;

      virtualHosts.${cfg.proxy.hostName}.extraConfig = ''
        tls internal
        reverse_proxy 127.0.0.1:${toString cfg.port}
      '';
    };
    #
    # Add Forgejo to homepage if homepage exists
    #
    my.programs.homelab.homepage.moduleServiceEntries = lib.mkAfter [
      {
        group = "Applications";
        name = "Forgejo";
        href = "http://127.0.0.1:3000/";
        icon = "forgejo";
      }
    ];
  };
}
