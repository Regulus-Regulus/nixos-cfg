{
  self,
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.jo.home.programs.desktop.stylix;
in {
  options.general.system.programs.desktop.stylix = {
    enable = mkEnableOption "Enable base libreoffice setup";
  };
  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      targets.grub.enable = true;
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
