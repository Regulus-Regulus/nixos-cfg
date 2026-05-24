{
  self,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.my.home.programs.ide.neovim;
in {
  options.my.home.programs.ide.neovim = {
    enable = mkEnableOption "Enable opinionated neovim setup";
  };
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;

      package = pkgs.lunarvim;
    };
  };
}
