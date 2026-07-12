{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.programs.homelab.paperless-ngx;
in {
  options.my.programs.homelab.paperless-ngx = {
    enable = lib.mkEnableOption "Paperlexx-ngx";
  };
}
