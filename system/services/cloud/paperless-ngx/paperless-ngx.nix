{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.homelab.system.services.cloud.paperless-ngx;
in {
  options.homelab.system.services.cloud.paperless-ngx = {
    enable = lib.mkEnableOption "Paperlexx-ngx";
  };
}
