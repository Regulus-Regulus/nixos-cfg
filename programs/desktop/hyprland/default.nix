{
  self,
  pkgs,
  ...
}: {
  imports = [
    #../../themes/Catppuccin # Catppuccin GTK and QT themes
    ./waybar
    # ./programs/wlogout
    # ./programs/rofi
    # #./programs/hypridle
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
    })
  ];
}
