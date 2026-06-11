{
  pkgs,
  lib,
  hostConfigName,
  inputs,
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

    jo.home = let
      laptop = hostConfigName == "laptop";
      desktop = hostConfigName == "desktop";
    in {
      programs = lib.mkMerge [
        (lib.mkIf (laptop || desktop) {
          desktop.gnome.enable = true;
          desktop.stylix.enable = true;
          browser.librewolf.enable = true;
          cli.yazi.enable = true;
          gameEngine.godot.enable = true;
          generators.opencode.enable = false;
          ide.vscodium.enable = true;
          ide.nvf.enable = true;
          media.steam.enable = true;
          terminal.kitty.enable = true;
          shell.zsh.enable = true;
        })

        (lib.mkIf laptop {
          # generators.opencode.models = ["foo" "bar"];
        })

        (lib.mkIf desktop {
          # generators.opencode.models = ["baz"];
        })
      ];
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
