{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.programs.homelab.paperless-ngx;
in {
  options.my.programs.homelab.paperless-ngx = {
    enable = lib.mkEnableOption "paperless-ngx";

    port = lib.mkOption {
      type = lib.types.port;
      default = 2283;
      description = "Internal port paperless-ngx listens on.";
    };

    proxy = {
      enable = lib.mkEnableOption "Expose paperless-ngx through Caddy";

      hostName = lib.mkOption {
        type = lib.types.str;
        default = "paperless-ngx.home";
        description = "Hostname used by Caddy to expose paperless-ngx.";
      };
    };
  };

  config = lib.mkIf cfg.enable {};
}
