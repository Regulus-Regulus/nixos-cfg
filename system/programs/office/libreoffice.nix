{
  self,
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.general.system.programs.office.libreoffice;
in {
  options.general.system.programs.office.libreoffice = {
    enable = mkEnableOption "Enable base libreoffice setup";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libreoffice-qt
      hunspell
      hunspellDicts.de_DE
      hunspellDicts.en_GB-large
    ];
  };
}
