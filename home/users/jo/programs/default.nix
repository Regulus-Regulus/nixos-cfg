{lib, ...}: {
  imports = [
    ./browser/firefox.nix
    ./browser/librewolf.nix
    ./interface/gnome.nix
    ./cli/yazi.nix
    ./ide/vscodium.nix
    ./ide/nvf.nix
    ./media/steam.nix
    ./terminal/kitty.nix
    ./shell/fish.nix
    ./shell/zsh.nix
  ];
}
