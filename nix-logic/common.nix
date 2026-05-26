{
  config,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.configurationLimit = 20;
  nix.gc.dates = "weekly";
  nix.gc.automatic = true;
  nix.settings.download-buffer-size = 524288000;
  home-manager.backupFileExtension = "bak";
}
