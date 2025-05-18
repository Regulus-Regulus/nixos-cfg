{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jo";
  home.homeDirectory = "/home/jo";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
  ];
  # Instead of relying on PAM, make it available in every zsh shell
  home.file.".zshenv".text = ''
    export TEST_USER_LOADED="yes"
  '';


  programs.home-manager.enable = true;
}
