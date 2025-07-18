{pkgs, ...}: {
  home.packages = with pkgs; [swaynotificationcenter];

  xdg.configFile."swaync/style.css".source = ./swaync/style.css;
  xdg.configFile."swaync/config.json".source = ./swaync/config.json;
}
