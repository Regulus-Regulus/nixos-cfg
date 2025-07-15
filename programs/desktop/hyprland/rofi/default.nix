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
      programs.rofi = with pkgs; {
        enable = true;
        package = rofi-wayland;
        terminal = "kitty";
        plugins = [
          pkgs.rofi-emoji-wayland # https://github.com/Mange/rofi-emoji 🤯
          pkgs.rofi-games # https://github.com/Rolv-Apneseth/rofi-games 🎮
        ];
      };
      xdg.configFile."rofi/themes/rounded-purple-dark.rasi".source = ./themes/rounded-purple-dark.rasi;
    })
  ];
}
