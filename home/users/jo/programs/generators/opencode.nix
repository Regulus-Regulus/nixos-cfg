{
  self,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.jo.home.programs.generators.opencode;
in {
  options.jo.home.programs.generators.opencode = {
    enable = mkEnableOption "Enable opinionated opencode setup";
  };
  config = mkIf cfg.enable {
    programs.opencode.enable = true;
  };
}
