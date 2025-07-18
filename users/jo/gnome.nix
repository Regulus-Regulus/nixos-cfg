{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.user-themes
  ];

  gtk = {
    enable = true;

    theme = {
      name = "Gruvbox-Material-Dark"; # Exakter Name!
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

  # Nur notwendig, wenn manche X11-Apps das brauchen
  home.sessionVariables = {
    GTK_THEME = "Gruvbox-Material-Dark";
  };

  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Gruvbox-Material-Dark"; # Wichtig für GNOME selbst
      icon-theme = "Papirus-Dark";
      cursor-theme = "Numix-Cursor";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Gruvbox-Material-Dark"; # Für Shell-Theming
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        pkgs.gnomeExtensions.user-themes.extensionUuid
      ];
    };
  };
}
