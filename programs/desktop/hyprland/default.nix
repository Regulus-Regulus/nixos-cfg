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
    # ./programs/wlogout
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
      imports = [
        ./rofi.nix
        ./waybar.nix
        ./swaync.nix
        ./swaylock.nix
      ];
      home.sessionVariables = {
        NIXOS_OZONE_WL = 1;
        __GL_GSYNC_ALLOWED = 0;
        __GL_VRR_ALLOWED = 1;
        _JAVA_AWT_WM_NONEREPARENTING = 1;
        SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
        DISABLE_QT5_COMPAT = 0;
        GDK_BACKEND = "wayland";
        ANKI_WAYLAND = 1;
        DIRENV_LOG_FORMAT = "";
        WLR_DRM_NO_ATOMIC = 1;
        QT_AUTO_SCREEN_SCALE_FACTOR = 1;
        QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
        QT_QPA_PLATFORMTHEME = "qt5ct";
        # QT_STYLE_OVERRIDE = "kvantum";
        MOZ_ENABLE_WAYLAND = 1;
        WLR_BACKEND = "vulkan";
        WLR_RENDERER = "gles2";
        WLR_NO_HARDWARE_CURSORS = 1;
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        GTK_THEME = "Colloid-Green-Dark-Gruvbox";
        GRIMBLAST_HIDE_CURSOR = 0;
      };
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
            "$mod SHIFT, L, exit"

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
        xwayland.force_zero_scaling = false;

        general = {
          layout = "dwindle";
          gaps_in = 6;
          gaps_out = 12;
          border_size = 2;
          "col.active_border" = "rgb(98971A) rgb(CC241D) 45deg";
          "col.inactive_border" = "0x00000000";
          # border_part_of_window = false;
          no_border_on_floating = false;
        };
        animations = {
          enabled = true;

          bezier = [
            "fluent_decel, 0, 0.2, 0.4, 1"
            "easeOutCirc, 0, 0.55, 0.45, 1"
            "easeOutCubic, 0.33, 1, 0.68, 1"
            "fade_curve, 0, 0.55, 0.45, 1"
          ];

          animation = [
            # name, enable, speed, curve, style

            # Windows
            "windowsIn,   0, 4, easeOutCubic,  popin 20%" # window open
            "windowsOut,  0, 4, fluent_decel,  popin 80%" # window close.
            "windowsMove, 1, 2, fluent_decel, slide" # everything in between, moving, dragging, resizing.

            # Fade
            "fadeIn,      1, 3,   fade_curve" # fade in (open) -> layers and windows
            "fadeOut,     1, 3,   fade_curve" # fade out (close) -> layers and windows
            "fadeSwitch,  0, 1,   easeOutCirc" # fade on changing activewindow and its opacity
            "fadeShadow,  1, 10,  easeOutCirc" # fade on changing activewindow for shadows
            "fadeDim,     1, 4,   fluent_decel" # the easing of the dimming of inactive windows
            # "border,      1, 2.7, easeOutCirc"  # for animating the border's color switch speed
            # "borderangle, 1, 30,  fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
            "workspaces,  1, 4,   easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
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
        monitor = {
        };
        misc = {
          disable_hyprland_logo = true;
          mouse_move_focuses_monitor = true;
          swallow_regex = "^(Alacritty|kitty)$";
          enable_swallow = true;
          vfr = true; # always keep on
          vrr = 1; # enable variable refresh rate (0=off, 1=on, 2=fullscreen only)
          disable_autoreload = true;
          always_follow_on_dnd = true;
          layers_hog_keyboard_focus = true;
          animate_manual_resizes = false;
          focus_on_activate = true;
          new_window_takes_over_fullscreen = 2;
          middle_click_paste = false;
        };
        decoration = {
          rounding = 3;
          # active_opacity = 0.90;
          # inactive_opacity = 0.90;
          # fullscreen_opacity = 1.0;

          blur = {
            enabled = true;
            size = 3;
            passes = 2;
            brightness = 1;
            contrast = 1.4;
            ignore_opacity = true;
            noise = 0;
            new_optimizations = true;
            xray = true;
          };

          shadow = {
            enabled = false;

            ignore_window = true;
            offset = "0 2";
            range = 20;
            render_power = 3;
            color = "rgba(00000055)";
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
