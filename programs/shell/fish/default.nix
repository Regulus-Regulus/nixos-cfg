{
  self,
  pkgs,
  lib,
  ...
}: {
  programs.fish.enable = true;

  home-manager.sharedModules = [
    (_: {
      programs.fish = {
        enable = true;
        shellAbbrs = {
          vim = "nvim";
        };
        functions = {
          rebuild = ''
            function rebuild
              ~/NixosConfiguration/scripts/rebuild.sh $argv
            end
          '';
        };
        plugins = [
          {
            name = "bobthefish";
            src = builtins.fetchTarball {
              url = "https://github.com/oh-my-fish/theme-bobthefish/archive/refs/heads/master.tar.gz";
              sha256 = "1q4ya4ndm7d7kk8ppzvpsxmk0gkdpaqhp4n5j0mpxq7vv6yrhwvi";
            };
          }
        ];
      };
    })
  ];
}
