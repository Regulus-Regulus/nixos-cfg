{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.my.programs.system.backup.borgbackup;
in {
  options.my.programs.system.backup.borgbackup = {
    enable = lib.mkEnableOption "Borg backup";
  };

  config = lib.mkIf cfg.enable {
    # TODO https://nixos.wiki/wiki/Borg_backup
  };
}
