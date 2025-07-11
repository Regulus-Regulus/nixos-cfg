{
  self,
  pkgs,
  ...
}: {
  home-manager.sharedModules = [
    (_: {
      programs.fish = {
        enable = true;
        shellAbbrs = {
          nrbuild = "sudo nixos-rebuild switch --flake ~/NixosConfiguration#laptop";
        };
      };
    })
  ];
}



