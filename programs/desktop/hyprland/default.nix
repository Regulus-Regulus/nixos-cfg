{
  self,
  pkgs,
  ...
}: {
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
