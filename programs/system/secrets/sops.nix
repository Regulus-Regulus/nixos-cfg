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
  options.my.programs.system.secrets.sops = {
    enable = mkEnableOption "Enable this configurations sops";

    sopsFileName = lib.mkOption {
      type = lib.types.str;
      description = "Name of the sopsFile for this machine.";
    };
  };
  config = mkIf cfg.enable {
    sops = {
      environment.variables.EDITOR = "nvim";
      environment.systemPackages = [pkgs.neovim];
      defaultSopsFile = "/var/lib/sops/${cfg.sopsFileName}.yaml";
      defaultSopsFormat = "yaml";

      age.keyFile = "/var/lib/sops/age-key.txt";
    };
  };
}
