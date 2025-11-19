{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra.url = "github:kamadorueda/alejandra/4.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    alejandra,
    stylix,
    ...
  } @ inputs: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          hostConfigName = "desktop"; # Defining hostname to allow users to install per-host
        };

        modules = [
          # Host Files
          ./hosts/desktop/configuration.nix
          ./hosts/desktop/hardware-configuration.nix

          # Nix Logic
          home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ./modules/nix-logic/common.nix
          ./modules/nix-logic/users.nix
          # module to set selectedUsers per-host:
          {
            myUsers.selectedUsers = ["jo"];
          }

          # Programs
          ./modules/programs/desktop/gnome
          ./modules/programs/evergreens.nix
          # ./modules/programs/cli/yazi
          ./modules/programs/shell/zsh
          ./modules/programs/shell/fish
          ./modules/programs/terminal/kitty
          ./modules/programs/browser/firefox
          ./modules/programs/browser/librewolf
          ./modules/programs/media/steam
          ./modules/programs/ide/vscodium
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          hostConfigName = "laptop"; # Defining hostname to allow users to install per-host
        };

        modules = [
          # Host Files
          ./hosts/laptop/configuration.nix
          ./hosts/laptop/hardware-configuration.nix

          # Nix Logic
          home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ./modules/nix-logic/common.nix
          ./modules/nix-logic/users.nix
          # module to set selectedUsers per-host:
          {
            myUsers.selectedUsers = ["jo" "katharina"];
          }

          # Programs
          ./modules/programs/desktop/gnome
          ./modules/programs/evergreens.nix
          # ./modules/programs/cli/yazi
          ./modules/programs/shell/zsh
          ./modules/programs/shell/fish
          ./modules/programs/terminal/kitty
          ./modules/programs/browser/firefox
          ./modules/programs/browser/librewolf
          ./modules/programs/media/steam
          ./modules/programs/ide/vscodium
        ];
      };
      bmo = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs;
          hostConfigName = "bmo"; # Defining hostname to allow users to install per-host
        };
        modules = [
          # Host Files
          ./hosts/bmo/configuration.nix
          nixos-hardware.nixosModules.raspberry-pi-5

          # IMPORTANT: Enables config.system.build.sdImage
          ({modulesPath, ...}: {
            imports = [
              "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
            ];
          })

          # Nix Logic
          home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ./modules/nix-logic/common.nix
          ./modules/nix-logic/users.nix
          # module to set selectedUsers per-host:
          {
            myUsers.selectedUsers = ["jo" "katharina"];
          }

          # Programs
          ./modules/programs/desktop/gnome
          ./modules/programs/evergreens.nix
          # ./modules/programs/cli/yazi
          ./modules/programs/shell/zsh
          ./modules/programs/terminal/kitty
          ./modules/programs/browser/firefox
          ./modules/programs/browser/librewolf
          ./modules/programs/ide/vscodium
        ];
      };
      HELPeR = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs;
          hostConfigName = "HELPeR"; # Defining hostname to allow users to install per-host
        };
        modules = [
          # Host Files
          ./hosts/HELPeR/configuration.nix
          nixos-hardware.nixosModules.raspberry-pi-4

          # IMPORTANT: Enables config.system.build.sdImage
          ({modulesPath, ...}: {
            imports = [
              "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
            ];
          })

          # Nix Logic
          home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ./modules/nix-logic/common.nix
          ./modules/nix-logic/users.nix
          # module to set selectedUsers per-host:
          {
            myUsers.selectedUsers = ["jo"];
          }

          ./modules/programs/virtualisation/podman
          # Programs
          ./modules/programs/evergreens.nix
          # ./modules/programs/cli/yazi
          ./modules/programs/shell/zsh
          ./modules/programs/terminal/kitty
          ./modules/programs/browser/firefox
          ./modules/programs/browser/librewolf
          ./modules/programs/ide/vscodium
        ];
      };
    };
  };
}
