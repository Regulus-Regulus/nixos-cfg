{
  pkgs,
  lib,
  config,
  hostConfigName,
  ...
}: {
  homeSettings = {
    home = {
      username = "test";
      homeDirectory = "/home/test";
      stateVersion = "24.11";
      packages = with pkgs;
        builtins.concatLists [
          # Always install
          [
          ]

          # Just on the laptop
          (lib.optionals (hostConfigName == "laptop") [
            ])

          # Only desktop
          (lib.optionals (hostConfigName == "desktop") [
            ])
        ];
    };

    programs = {
      home-manager.enable = true;

      fish = {
        enable = true;
      };

      zsh = {
        enable = false;
        # Overrides und Ergänzungen zum Default:
        shellAliases = {
          # z.B. eigene Aliase, die zum Default hinzukommen
          ll = "${pkgs.eza}/bin/eza -lha --icons=auto";
          ls = "${pkgs.eza}/bin/eza -1 --icons=auto";
        };
        oh-my-zsh.plugins = lib.mkForce [
          "docker" # zusätzlich zum Default "git", "gitignore", "z"
        ];
      };
    };
  };

  systemSettings = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["wheel"];
  };
}
