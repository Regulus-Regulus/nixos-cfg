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
      default = 2283;
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
  };

  config = lib.mkIf cfg.enable {};
}
