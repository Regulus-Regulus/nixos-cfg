{
  self,
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.my.programs.system.secrets.sops;
in {
  options.my.programs.system.office.libreoffice = {
    enable = mkEnableOption "Enable base libreoffice setup";
  };
  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = "/var/lib/sops/homelab.yaml";
      defaultSopsFormat = "yaml";

      age.keyFile = "/var/lib/sops/age-key.txt";

      secrets.test_secret = {};
    };
  };
}
