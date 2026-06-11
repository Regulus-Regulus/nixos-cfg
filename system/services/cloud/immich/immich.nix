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

    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/immich";
      description = "Persistent Immich data directory";
    };
  };

  config = lib.mkIf cfg.enable {
    # --- Persistent storage ---
    systemd.tmpfiles.rules = [
      "d ${cfg.dataDir} 0755 root root -"
      "d ${cfg.dataDir}/library 0755 root root -"
      "d ${cfg.dataDir}/postgres 0755 root root -"
    ];

    # --- Immich configuration files ---
    environment.etc."immich/docker-compose.yml".text = ''
      version: "3.8"

      services:
        immich-server:
          container_name: immich_server
          image: ghcr.io/immich-app/immich-server:release

          ports:
            - "2283:2283"

          volumes:
            - ${cfg.dataDir}/library:/usr/src/app/upload

          env_file:
            - .env

          depends_on:
            - redis
            - database

          restart: always

        redis:
          container_name: immich_redis
          image: docker.io/redis:6.2-alpine
          restart: always

        database:
          container_name: immich_postgres
          image: docker.io/tensorchord/pgvecto-rs:pg14-v0.2.0

          environment:
            POSTGRES_USER: postgres
            POSTGRES_PASSWORD: postgres
            POSTGRES_DB: immich

          volumes:
            - ${cfg.dataDir}/postgres:/var/lib/postgresql/data

          restart: always
    '';

    environment.etc."immich/.env".text = ''
      TZ=Europe/Berlin
    '';

    # --- Systemd service ---
    systemd.services.immich = {
      description = "Immich Docker Compose Stack";

      after = ["podman.service"];
      requires = ["podman.service"];
      environment = {
        DOCKER_HOST = "unix:///run/podman/podman.sock";
      };
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;

        WorkingDirectory = "/etc/immich";

        ExecStart = "${pkgs.docker-compose}/bin/docker-compose up -d";

        ExecStop = "${pkgs.docker-compose}/bin/docker-compose down";
      };
    };
  };
}
