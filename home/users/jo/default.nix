{
  pkgs,
  lib,
  hostConfigName,
  ...
}: {
  users.users.jo = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel"];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBrd6LHfR66IA+p+40RyIqGtYqFrcdf09p5REwTjkWZW jo@rr-desktop"
    ];
  };

  home-manager.users.jo = {
    imports = [
      ./programs
    ];
    my.home.programs = {
      inteface.gnome = hostConfigName == "laptop" || hostConfigName == "desktop";
      browser.firefox = hostConfigName == "laptop" || hostConfigName == "desktop";
      browser.librewolf = hostConfigName == "laptop" || hostConfigName == "desktop";
      cli.yazi = hostConfigName == "laptop" || hostConfigName == "desktop";
      ide.vscodium = hostConfigName == "laptop" || hostConfigName == "desktop";
      media.steam = hostConfigName == "laptop" || hostConfigName == "desktop";
      shell.zsh = hostConfigName == "laptop" || hostConfigName == "desktop";
      shell.fish = false;
    };

    home = {
      username = "jo";
      homeDirectory = "/home/jo";
      stateVersion = "24.11";

      packages = with pkgs;
        builtins.concatLists [
          # Always
          [
            iw
            gnupg
            thunderbird
            wget
          ]

          # Laptop or Desktop
          (lib.optionals (hostConfigName == "laptop" || hostConfigName == "desktop") [
            nmap
            wireshark
            discord
            nmap
            obsidian
            traceroute
          ])
        ];
    };

    programs = {
      home-manager.enable = true;

      zsh = {
        enable = true;

        shellAliases = {
          ll = "${pkgs.eza}/bin/eza -lha --icons=auto";
          ls = "${pkgs.eza}/bin/eza -1 --icons=auto";
        };

        oh-my-zsh.plugins = lib.mkForce [
          "docker"
        ];

        sessionVariables = {
          NIX_SSHOPTS = "-p 7373";
        };
      };
    };
  };
}
