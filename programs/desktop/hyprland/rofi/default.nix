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
      plugins = with pkgs; [
        rofi-emoji-wayland # https://github.com/Mange/rofi-emoji 🤯
        rofi-games # https://github.com/Rolv-Apneseth/rofi-games 🎮
      ];
      xdg.configFile."rofi/config-music.rasi".source = ./themes/rounded-purple-dark.rasi;
    })
  ];
}
