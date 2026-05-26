{
  self,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.jo.home.programs.media.steam;
in {
  options.jo.home.programs.media.steam = {
    enable = mkEnableOption "Enable opinionated steam setup";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      steam
      libva # Required for Steam to run properly
      libvdpau # Required for Steam to run properly
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      mesa
      gamemode
      mangohud
    ];
  };
}
