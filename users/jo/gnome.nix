{pkgs, ...}: let
  gruvboxTheme = pkgs.gruvbox-gtk-theme.overrideAttrs (oldAttrs: {
    colorVariants = ["dark"]; # dark, light
    sizeVariants = ["standard"]; # compact, standard
    themeVariants = ["pink"]; # default, green, grey, orange, pink, purple, red, teal, yellow, all
    tweakVariants = ["medium"]; # medium, soft, black, float, outline, macos
  });
in {
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.user-themes
  ];

  gtk = {
    enable = true;

    theme = {
      name = "Gruvbox-Dark-Standard-Pink-Medium"; # Gruvbox-<Color>-<Size>-<Theme>-<Tweak>
      package = gruvboxTheme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Gruvbox-Dark-Standard-Pink-Medium";
  };

  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Gruvbox-Dark-Standard-Pink-Medium";
      icon-theme = "Papirus-Dark";
      cursor-theme = "Numix-Cursor";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Gruvbox-Dark-Standard-Pink-Medium";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        pkgs.gnomeExtensions.user-themes.extensionUuid
      ];
    };
  };
}
