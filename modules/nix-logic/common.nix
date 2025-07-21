{
  config,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.configurationLimit = 20;
  nix.gc.dates = "weekly";
  nix.gc.automatic = true;

  home-manager.backupFileExtension = "bak";
}
