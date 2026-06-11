{
  self,
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.my.system.general.programs.office.libreoffice;
in {
  options.my.system.general.programs.office.libreoffice = {
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
