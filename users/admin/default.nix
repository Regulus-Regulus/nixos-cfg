{
  pkgs,
  lib,
  config,
  hostConfigName,
  ...
}: {
  homeSettings = {
    home = {
      username = "admin";
      homeDirectory = "/home/admin";
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
        enable = false;
      };

      zsh = {
        enable = true;
        # Overrides und Ergänzungen zum Default:
        shellAliases = {
          # z.B. eigene Aliase, die zum Default hinzukommen
          ll = "${pkgs.eza}/bin/eza -lha --icons=auto";
          ls = "${pkgs.eza}/bin/eza -1 --icons=auto";
        };
        oh-my-zsh.plugins =
          lib.mkForce [
          ];
      };
    };
  };

  systemSettings = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
    hashedPassword = "$y$j9T$VS27i4/F0W/W32n1XV9j21$C0nf0qoRT60Pf2bc00P3mU0Q3i1sS9Dj86gXVvFrw65";
  };
}
