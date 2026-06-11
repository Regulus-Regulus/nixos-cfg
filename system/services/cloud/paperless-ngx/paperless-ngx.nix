{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.system.homelab.services.cloud.paperless-ngx;
in {
  options.my.system.homelab.services.cloud.paperless-ngx = {
    enable = lib.mkEnableOption "Paperlexx-ngx";
  };
}
