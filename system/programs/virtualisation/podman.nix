{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.my.system.general.programs.virtualisation.podman;
in {
  options.my.programs.virtualisation.podman = {
    enable = lib.mkEnableOption "Podman container runtime";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      podman
      docker-compose
    ];

    virtualisation = {
      containers.enable = true;

      oci-containers.backend = "podman";

      podman = {
        enable = true;

        dockerCompat = true;

        dockerSocket.enable = true;

        autoPrune = {
          enable = true;
        };

        defaultNetwork.settings = {
          dns_enabled = true;
        };
      };
    };

    virtualisation.containers.containersConf.settings = {
      containers = {
        log_driver = "journald";
      };
    };
  };
}
