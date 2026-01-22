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

  dconf = {
    enable = true;

    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        icon-theme = "Papirus-Dark";
        cursor-theme = "Numix-Cursor";
      };

      "org/gnome/shell/extensions/paperwm" = {
        winprops = [
          ''
            {
              "wm_class": "org.gnome.Settings",
              "title": "Settings",
              "scratch_layer": true,
              "focus": true
            }
          ''
          ''
            {
              "wm_class": "Steam",
              "title": "Steam",
              "scratch_layer": true,
              "focus": true
            }
          ''
        ];
      };

      # https://github.com/paperwm/PaperWM/blob/3be8a508470a319be343c4f7171a44c69b6105a8/prefsKeybinding.js#L74
      "org/gnome/shell/extensions/paperwm" = {
        "switch-up-workspace" = ["<Super>w"];
        "switch-right" = ["<Super>d"];
        "switch-left" = ["<Super>a"];
        "move-right" = ["<Ctrl><Super>d"];
        "move-left" = ["<Ctrl><Super>a"];
        "move-down-workspace" = ["<Ctrl><Super>s"];
        "move-up-workspace" = ["<Ctrl><Super>w"];
        "center-horizontally" = [];
      };

      # https://github.com/paperwm/PaperWM/blob/3be8a508470a319be343c4f7171a44c69b6105a8/prefsKeybinding.js#L74
      "org/gnome/shell/extensions/paperwm/keybindings" = {
        "switch-down-workspace" = ["<Super>s"];
        "switch-up-workspace" = ["<Super>w"];
        "switch-right" = ["<Super>d"];
        "switch-left" = ["<Super>a"];
        "move-right" = ["<Ctrl><Super>d"];
        "move-left" = ["<Ctrl><Super>a"];
        "move-down-workspace" = ["<Ctrl><Super>s"];
        "move-up-workspace" = ["<Ctrl><Super>w"];
        "center-horizontally" = [];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Kitty Terminal";
        command = "kitty";
        binding = "<Ctrl><Alt>t";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        name = "Librewolf";
        command = "librewolf";
        binding = "<Super>b";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        name = "VSCodium";
        command = "codium";
        binding = "<Super>c";
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        ];
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
  };
}
