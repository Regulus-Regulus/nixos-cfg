{
  pkgs,
  lib,
  config,
  hostConfigName,
  ...
}: {
  homeSettings = {
    imports = [
      ./gnome.nix
      ./hyfetch.nix
      ./stylix.nix
    ];
    home = {
      username = "jo";
      homeDirectory = "/home/jo";
      stateVersion = "24.11";

      packages = with pkgs;
        builtins.concatLists [
          # Always install
          [
            iw
            gnupg
            thunderbird
            wget
          ]

          # Just on the laptop
          (lib.optionals (hostConfigName == "laptop") [
            nmap
            wireshark
            discord
            # hydra
            # nikto
            # amass
            traceroute
            # etherape
            # sqlmap
            # aircrack-ng
            # john
          ])

          # Only desktop
          (lib.optionals (hostConfigName == "desktop") [
            discord
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
        oh-my-zsh.plugins = lib.mkForce [
          "docker" # zusätzlich zum Default "git", "gitignore", "z"
        ];
      };
    };
  };
  openssh.authorizedKeys.keys = [ 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBrd6LHfR66IA+p+40RyIqGtYqFrcdf09p5REwTjkWZW jo@rr-desktop" # Helper 
    ];
  systemSettings = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
  };
}
