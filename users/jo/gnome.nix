{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.user-themes
  ];

  gtk = {
    enable = true;

    # theme = {
    #   name = "n";
    #   package = pkgs.gruvbox-gtk-theme;
    # };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
  };

  # home.sessionVariables = {
  #   GTK_THEME = "Gruvbox-Dark";
  # };

  dconf.enable = true;

  dconf.settings = let
    cbPrefix = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings";
    makeBinding = name: cfg: {
      "${cbPrefix}/${name}/" = cfg;
    };

    customBindings = {
      kitty = {
        name = "Kitty Terminal";
        command = "kitty";
        binding = "<Ctrl><Alt>t";
      };

      firefox = {
        name = "Firefox";
        command = "firefox";
        binding = "<Super>f";
      };
    };

    # Merge them into a single attrset with full paths
    customBindingAttrs = builtins.foldl' (
      acc: name:
        acc // (makeBinding name (customBindings.${name}))
    ) {} (builtins.attrNames customBindings);
  in {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Nordic";
      icon-theme = "Papirus-Dark";
      cursor-theme = "Numix-Cursor";
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 10;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = builtins.map (name: "/${cbPrefix}/${name}/") (builtins.attrNames customBindings);
    };

    # "org/gnome/shell/extensions/user-theme" = {
    #   name = "Gruvbox-dark";
    # };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        pkgs.gnomeExtensions.user-themes.extensionUuid
      ];
    };
  };
}
