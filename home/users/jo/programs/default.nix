{lib, ...}: {
  imports = [
    ./browser/firefox.nix
    ./browser/librewolf.nix
    ./interface/gnome.nix
    ./cli/yazi.nix
    ./ide/vscodium.nix
    ./media/steam.nix
    ./shell/fish.nix
    ./shell/zsh.nix
  ];
}
