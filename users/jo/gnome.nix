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

      "org/gnome/shell/extensions/paperwm/keybindings" = {
        "switch-down-workspace" = "<Super>s";
        "switch-up-workspace" = "<Super>w";
        "switch-right" = "<Super>d";
        "switch-left" = "<Super>a";
        "restore-keybinds" = "";
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

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
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
