{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.user-themes
    gnomeExtensions.paperwm
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

    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      switch-to-workspace-10 = ["<Super>0"];
      switch-to-workspace-right = ["<Super>Right"];
      switch-to-workspace-left = ["<Super>Left"];
      move-to-workspace-1 = ["<Super><Alt>1"];
      move-to-workspace-2 = ["<Super><Alt>2"];
      move-to-workspace-3 = ["<Super><Alt>3"];
      move-to-workspace-4 = ["<Super><Alt>4"];
      move-to-workspace-5 = ["<Super><Alt>5"];
      move-to-workspace-6 = ["<Super><Alt>6"];
      move-to-workspace-7 = ["<Super><Alt>7"];
      move-to-workspace-8 = ["<Super><Alt>8"];
      move-to-workspace-9 = ["<Super><Alt>9"];
      move-to-workspace-10 = ["<Super><Alt>0"];
      move-to-workspace-right = ["<Super><Alt>Right"];
      move-to-workspace-left = ["<Super><Alt>Left"];
      move-to-side-w = [];
      move-to-side-e = [];
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 10;
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
        pkgs.gnomeExtensions.paperwm.extensionUuid
      ];
    };
  };
}
