{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.programs.homelab.redis;
in {
  options.my.programs.homelab.redis = {
    enable = lib.mkEnableOption "redis";

    port = lib.mkOption {
      type = lib.types.port;
      default = 6379;
      description = "Internal port redis listens on.";
    };
  };

  config = lib.mkIf cfg.enable {};
}
