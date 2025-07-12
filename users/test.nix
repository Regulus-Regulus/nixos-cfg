{
  pkgs,
  config,
  ...
}: {
  homeSettings = {
    home.username = "test";
    home.homeDirectory = "/home/test";
    home.stateVersion = "24.11";
    programs.home-manager.enable = true;

    packages = with pkgs; [
    ];
  };

  systemSettings = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
  };
}
