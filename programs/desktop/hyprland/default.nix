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

            # Move focus with mod + arrow keys
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"

            # Move focus with mod + HJKL keys
            "$mod, h, movefocus, l"
            "$mod, l, movefocus, r"
            "$mod, k, movefocus, u"
            "$mod, j, movefocus, d"
          ]
          ++ (builtins.concatLists (builtins.genList (x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              "$mod CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
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
        animations = {
          enabled = true;
          bezier = [
            "linear, 0, 0, 1, 1"
            "md3_standard, 0.2, 0, 0, 1"
            "md3_decel, 0.05, 0.7, 0.1, 1"
            "md3_accel, 0.3, 0, 0.8, 0.15"
            "overshot, 0.05, 0.9, 0.1, 1.1"
            "crazyshot, 0.1, 1.5, 0.76, 0.92"
            "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
            "fluent_decel, 0.1, 1, 0, 1"
            "easeInOutCirc, 0.85, 0, 0.15, 1"
            "easeOutCirc, 0, 0.55, 0.45, 1"
            "easeOutExpo, 0.16, 1, 0.3, 1"
          ];
          animation = [
            "windows, 1, 3, md3_decel, popin 60%"
            "border, 1, 10, default"
            "fade, 1, 2.5, md3_decel"
            # "workspaces, 1, 3.5, md3_decel, slide"
            "workspaces, 1, 3.5, easeOutExpo, slide"
            # "workspaces, 1, 7, fluent_decel, slidefade 15%"
            # "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
            "specialWorkspace, 1, 3, md3_decel, slidevert"
          ];
        };
        layerrule = [
          "blur, rofi"
          "ignorezero, rofi"
          "ignorealpha 0.7, rofi"

          "blur, swaync-control-center"
          "blur, swaync-notification-window"
          "ignorezero, swaync-control-center"
          "ignorezero, swaync-notification-window"
          "ignorealpha 0.7, swaync-control-center"
          # "ignorealpha 0.8, swaync-notification-window"
          # "dimaround, swaync-control-center"
        ];
        misc = {
          disable_hyprland_logo = true;
          mouse_move_focuses_monitor = true;
          swallow_regex = "^(Alacritty|kitty)$";
          enable_swallow = true;
          vfr = true; # always keep on
          vrr = 0; # enable variable refresh rate (0=off, 1=on, 2=fullscreen only)
        };
        decoration = {
          shadow.enabled = false;
          rounding = 8;
          dim_special = 0.3;
          blur = {
            enabled = true;
            special = true;
            size = 10;
            passes = 3;
            new_optimizations = true;
            ignore_opacity = true;
            xray = false;
            noise = 0.04;
          };
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
