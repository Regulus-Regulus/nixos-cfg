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
    inputs.stylix.homeModules.stylix
    ./desktop/stylix.nix
    ./cli/yazi.nix
    ./gameengine/godot.nix
    ./generators/opencode.nix
    ./ide/vscodium.nix
    inputs.nvf.homeManagerModules.default
    ./ide/nvf.nix
    ./media/steam.nix
    ./terminal/kitty.nix
    ./shell/fish.nix
    ./shell/zsh.nix
  ];
}
