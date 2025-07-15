{
  self,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
  };

  imports = [
    #../../themes/Catppuccin # Catppuccin GTK and QT themes
    ./waybar.nix
    # ./programs/wlogout
    ./rofi.nix
    # #./programs/hypridle#
    # ./programs/hyprlock
    # ./programs/swaync
    # ./programs/dunst
  ];
  environment.variables = {
    ELECTRON_ENABLE_WAYLAND = "1";
  };
  # Display Manager für Hyprland
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";
  home-manager.sharedModules = [
    (_: {
      wayland.windowManager.hyprland.enable = true; # enable Hyprland
      wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";
        bind =
          [
            "$mod, F, exec, firefox"
            "$mod, T, exec, kitty"
            "$mod, C, exec, codium"
            "$mod, Space, exec, rofi -show drun"
            "$mod Ctrl Alt, Q, exec, poweroff"

            # Move focus with mainMod + arrow keys
            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"

            # Move focus with mainMod + HJKL keys
            "$mainMod, h, movefocus, l"
            "$mainMod, l, movefocus, r"
            "$mainMod, k, movefocus, u"
            "$mainMod, j, movefocus, d"
          ]
          ++ (builtins.concatLists (builtins.genList (x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              "$mainMod CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
            ])
            10));
        xwayland.force_zero_scaling = true;
        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "GDK_BACKEND,wayland,x11,*"
          "NIXOS_OZONE_WL,1"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
          "MOZ_ENABLE_WAYLAND,1"
          "OZONE_PLATFORM,wayland"
          "EGL_PLATFORM,wayland"
          "CLUTTER_BACKEND,wayland"
          "SDL_VIDEODRIVER,wayland"
          "QT_QPA_PLATFORM,wayland;xcb"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_QPA_PLATFORMTHEME,qt6ct"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
          # "WLR_RENDERER_ALLOW_SOFTWARE,1"
          "NIXPKGS_ALLOW_UNFREE,1"

          # mouse cursor
          "XCURSOR_THEME,Bibata-Modern-Ice"
          "XCURSOR_SIZE,24"
        ];
        general = {
          gaps_in = 4;
          gaps_out = 9;
          border_size = 2;
          "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
          "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
          resize_on_border = true;
          layout = "master"; # dwindle or master
          # allow_tearing = true; # Allow tearing for games (use immediate window rules for specific games or all titles)
        };
        input = {
          kb_layout = "de";
          kb_variant = "";
          repeat_delay = 300; # or 212
          repeat_rate = 30;

          follow_mouse = 1;

          touchpad.natural_scroll = false;

          tablet.output = "current";

          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
          force_no_accel = true;
        };
        exec-once = [
          "waybar"
        ];
      };
    })
  ];
}
