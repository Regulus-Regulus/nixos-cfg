{ pkgs, config, ... }:

{
  home = {
    home.username = "test";
    home.homeDirectory = "/home/test";
    home.stateVersion = "24.11";
    programs.home-manager.enable = true;

    packages = with pkgs; [
    ];
  };

  system = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };
}