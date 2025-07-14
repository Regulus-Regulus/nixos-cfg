{
  self,
  pkgs,
  ...
}: {
  imports = [
    #../../themes/Catppuccin # Catppuccin GTK and QT themes
    ./waybar
    # ./programs/wlogout
    ./rofi.nix
    # #./programs/hypridle#
    # ./programs/hyprlock
    # ./programs/swaync
    # ./programs/dunst
  ];

  # Display Manager für Hyprland
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";
  programs.hyprland.enable = true;
  home-manager.sharedModules = [
    (_: {
      wayland.windowManager.hyprland.enable = true; # enable Hyprland
      wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";
        bind = [
          "$mod, F, exec, firefox"
          "$mod, T, exec, kitty"
          "$mod, V, exec, vscodium"
          "$mod, Space, exec, rofi -show drun"
        ];
        exec-once = [
          "waybar"
        ];
      };
    })
  ];
}
