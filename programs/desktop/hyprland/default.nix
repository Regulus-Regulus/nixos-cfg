{
  self,
  pkgs,
  ...
}: {
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
    ELECTRON_FORCE_DEVICE_SCALE_FACTOR = "1";
    ELECTRON_ENABLE_WAYLAND = "1 codium";
  };
  # Display Manager für Hyprland
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";
  programs.hyprland.enable = true;
  home-manager.sharedModules = [
    (_: {
      wayland.windowManager.hyprland.enable = true; # enable Hyprland
      wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";
        bind =
          [
            "$mod, F, exec, firefox"
            "$mod, T, exec, kitty"
            "$mod, V, exec, codium"
            "$mod, Space, exec, rofi -show drun"
          ]
          ++ (
            # workspaces
            builtins.concatLists (builtins.genList (
                i: let
                  ws = i + 1;
                in [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              )
              9)
          );
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
