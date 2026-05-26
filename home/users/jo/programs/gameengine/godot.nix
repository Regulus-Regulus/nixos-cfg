{
  self,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.jo.home.programs.gameEngine.godot;
in {
  options.jo.home.programs.gameEngine.godot = {
    enable = mkEnableOption "Enable opinionated godot setup";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      godot
    ];
  };
}
