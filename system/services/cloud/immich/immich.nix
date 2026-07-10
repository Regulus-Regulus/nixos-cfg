{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.system.homelab.services.cloud.immich;
in {
  options.my.system.homelab.services.cloud.immich = {
    enable = lib.mkEnableOption "Immich";

    proxy = {
      enable = lib.mkEnableOption "Expose Immich through Caddy";

      hostName = lib.mkOption {
        type = lib.types.str;
        default = "immich.home";
        description = "Hostname used by Caddy to expose Immich.";
      };
    };

    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/immich";
      description = "Persistent Immich data directory";
    };
  };

  config = lib.mkIf cfg.enable {
    my.system.general.programs.virtualisation.podman.enable = true;

    services.caddy = lib.mkIf cfg.proxy.enable {
      enable = true;

      virtualHosts.${cfg.proxy.hostName}.extraConfig = ''
        reverse_proxy 127.0.0.1:2283
      '';
    };

    # Persistent storage
    systemd.tmpfiles.rules = [
      "d ${cfg.dataDir} 0755 root root -"
      "d ${cfg.dataDir}/library 0755 root root -"
      "d ${cfg.dataDir}/postgres 0755 root root -"
    ];

    # Immich configuration files
    environment.etc."immich/docker-compose.yml".source = ./docker-compose.yaml;
    environment.etc."immich/.env".source = ./.env;

    # Systemd service
    systemd.services.immich = {
      description = "Immich Docker Compose Stack";

      after = [
        "podman.service"
      ];
      requires = [
        "podman.service"
      ];
      wantedBy = [
        "multi-user.target"
      ];

      restartTriggers = [
        config.environment.etc."immich/docker-compose.yml".source
        config.environment.etc."immich/.env".source
      ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;

        WorkingDirectory = "/etc/immich";

        ExecStart = "${pkgs.docker}/bin/docker compose up -d";
        ExecStop = "${pkgs.docker}/bin/docker compose down";
      };
    };
  };
}
