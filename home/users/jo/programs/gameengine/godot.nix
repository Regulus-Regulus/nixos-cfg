{
  self,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.my.home.programs.gameEngine.godot;
in {
  options.my.home.programs.gameEngine.godot = {
    enable = mkEnableOption "Enable opinionated godot setup";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      godot
    ];
  };
}
