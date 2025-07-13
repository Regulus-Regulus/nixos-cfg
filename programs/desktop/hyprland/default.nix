{
  self,
  pkgs,
  ...
}: {
  programs.hyprland.enable = true;
  home-manager.sharedModules = [
    (_: {
      wayland.windowManager.hyprland.enable = true; # enable Hyprland
    })
  ];
}
