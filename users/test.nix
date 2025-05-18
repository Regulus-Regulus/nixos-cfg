{ pkgs, config, ... }:

{
  home = {
    home.username = "test";
    home.homeDirectory = "/home/test";
    home.stateVersion = "24.11";
    programs.home-manager.enable = true;

    home.sessionVariables.TEST_USER_LOADED = "1";
  };

  system = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };
}