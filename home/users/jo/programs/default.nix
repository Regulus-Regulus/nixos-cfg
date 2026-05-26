{
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    ./browser/firefox.nix
    ./browser/librewolf.nix
    ./desktop/gnome.nix
    ./cli/yazi.nix
    ./gameengine/godot.nix
    ./ide/vscodium.nix
    inputs.nvf.homeManagerModules.default
    ./ide/nvf.nix
    ./media/steam.nix
    ./terminal/kitty.nix
    ./shell/fish.nix
    ./shell/zsh.nix
  ];
}
