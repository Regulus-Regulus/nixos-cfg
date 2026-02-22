{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./programs/browser/firefox.nix
  ];
}
