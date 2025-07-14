{
  self,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    rofi-wayland
  ];
  home-manager.sharedModules = [
    (_: {
      programs.rofi.enable = true;
      programs.rofi.package = pkgs.rofi-wayland;
      programs.rofi.terminal = "kitty";
    })
  ];
}
