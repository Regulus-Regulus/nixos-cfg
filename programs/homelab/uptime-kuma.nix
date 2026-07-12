{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.programs.homelab.uptime-kuma;
in {
  options.my.programs.homelab.uptime-kuma = {
    enable = lib.mkEnableOption "uptime-kuma";

    port = lib.mkOption {
      type = lib.types.port;
      default = 2283;
      description = "Internal port uptime-kuma listens on.";
    };

    proxy = {
      enable = lib.mkEnableOption "Expose uptime-kuma through Caddy";

      hostName = lib.mkOption {
        type = lib.types.str;
        default = "uptime-kuma.home";
        description = "Hostname used by Caddy to expose uptime-kuma.";
      };
    };
  };

  config = lib.mkIf cfg.enable {};
}
