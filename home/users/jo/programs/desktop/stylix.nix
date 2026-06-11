{
  self,
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.jo.home.programs.desktop.stylix;
in {
  options.jo.home.programs.desktop.stylix = {
    enable = mkEnableOption "Enable Stylix setup";
  };
  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = true;

      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      targets.gnome.enable = true;
      targets.nvf.enable = false;
      fonts = {
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };

        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };

        monospace = {
          package = pkgs.maple-mono.NF;
          name = "Maple Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
