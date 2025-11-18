{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.user-themes
    gnomeExtensions.paperwm
  ];

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
  };

  dconf.enable = true;

  dconf.settings = let
    cbPrefix = "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings";
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
        name = "Librewolf";
        command = "librewolf";
        binding = "<Super>b";
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
      icon-theme = "Papirus-Dark";
      cursor-theme = "Numix-Cursor";
    };

    "org/gnome/shell/extensions/paperwm" = {
      "switch-down-workspace" = "<Super>s";
      "switch-up-workspace" = "<Super>w";
      "switch-right" = "<Super>d";
      "switch-left" = "<Super>a";
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = builtins.map (name: "/${cbPrefix}/${name}/") (builtins.attrNames customBindings);
    };

    "org/gnome/desktop/wm/keybindings" = {
      move-to-workspace-left = [];
      move-to-workspace-right = [];
      move-to-workspace-up = [];
      move-to-workspace-down = [];

      switch-to-workspace-up = [];
      switch-to-workspace-down = [];
      switch-to-workspace-left = [];
      switch-to-workspace-right = [];

      # Window movement
      move-left = [];
      move-right = [];
    };

    "org/gnome/shell/keybindings" = {
      toggle-overview = []; # unbinds <Super>s
      toggle-application-view = []; # unbinds <Super>
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
