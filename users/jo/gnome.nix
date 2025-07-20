{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.user-themes
  ];

  gtk = {
    enable = true;

    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
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
    GTK_THEME = "Gruvbox-Dark";
  };

  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Gruvbox-Dark";
      icon-theme = "Papirus-Dark";
      cursor-theme = "Numix-Cursor";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Gruvbox-dark";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        pkgs.gnomeExtensions.user-themes.extensionUuid
      ];
    };
  };
}
