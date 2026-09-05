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

    moduleServiceEntries = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          group = lib.mkOption {type = lib.types.str;};
          name = lib.mkOption {type = lib.types.str;};
          href = lib.mkOption {type = lib.types.str;};
          icon = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
          };
        };
      });
      description = "Option to allow applications to manage their Homepage Service Entry via their NixOS Module Configuration.";
      default = [];
    };
  };

  config = lib.mkIf cfg.enable {
    services.homepage-dashboard = {
      enable = true;
      listenPort = cfg.port;

      settings = {
        title = "Homelab";
        theme = "dark";
        headerStyle = "clean";
      };
      services = lib.mapAttrsToList (group: entries: {
        "${group}" =
          map (service: {
            "${service.name}" =
              {
                href = service.href;
              }
              // lib.optionalAttrs (service.icon != null) {
                icon = service.icon;
              };
          })
          entries;
      }) (lib.groupBy (service: service.group) cfg.moduleServiceEntries);
      # ++ [
      #   {
      #     # Manual entries
      #   }
      # ];
      widgets = [
        {
          resources = {
            cpu = true;
            disk = "/";
            memory = true;
          };
        }
      ];
    };
    # CONFIG TODO
    # https://search.nixos.org/options?channel=26.05&query=homepage-dashboard&type=options#show=option%253Aservices.homepage-dashboard.listenPort
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
