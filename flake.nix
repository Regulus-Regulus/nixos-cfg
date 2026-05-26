{
  description = "Nixos config flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      # url = "github:nix-community/home-manager/release-25.11";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      # url = "github:danth/stylix/release-25.11";
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
    alejandra.url = "github:kamadorueda/alejandra/4.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    nixos-raspberrypi,
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
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }

          # Host Files
          ./hosts/laptop/configuration.nix
          ./hosts/laptop/hardware-configuration.nix

          # Nix Logic
          inputs.stylix.nixosModules.stylix
          ./nix-logic/common.nix
          ./home/users/jo
          ./home/users/katharina
          # ./nix-logic/users.nix
          # # module to set selectedUsers per-host:
          # {
          #   myUsers.selectedUsers = ["jo" "katharina"];
          # }

          # Programs
          ./system/programs/desktop/gnome
          ./system/programs/evergreens.nix
          # ./system/programs/cli/yazi
          # ./system/programs/shell/fish
          # ./system/programs/terminal/kitty
          # ./system/programs/browser/firefox
          # ./system/programs/browser/firefox
          # ./system/programs/media/steam
          # ./system/programs/ide/vscodium
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          hostConfigName = "laptop"; # Defining hostname to allow users to install per-host
        };

        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }

          # Host Files
          ./hosts/laptop/configuration.nix
          ./hosts/laptop/hardware-configuration.nix

          # Nix Logic
          inputs.stylix.nixosModules.stylix
          ./nix-logic/common.nix
          ./home/users/jo
          ./home/users/katharina
          # ./nix-logic/users.nix
          # # module to set selectedUsers per-host:
          # {
          #   myUsers.selectedUsers = ["jo" "katharina"];
          # }

          # Programs
          ./system/programs/desktop/gnome
          ./system/programs/evergreens.nix
          # ./system/programs/cli/yazi
          # ./system/programs/shell/fish
          # ./system/programs/terminal/kitty
          # ./system/programs/browser/firefox
          # ./system/programs/browser/firefox
          # ./system/programs/media/steam
          # ./system/programs/ide/vscodium
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
          ./hosts/HELPeR/hardware-configuration.nix

          # Nix Logic
          home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ./nix-logic/common.nix
          ./nix-logic/users.nix
          ./system/programs/evergreens.nix
          ./system/programs/terminal/kitty
          ./system/programs/network/pihole
          # module to set selectedUsers per-host:
          {
            myUsers.selectedUsers = ["jo" "admin"];
          }

          ./system/programs/virtualisation/podman
          # Programs
          # ./system/programs/cli/yazi
          ./system/programs/shell/zsh
        ];
      };
    };
  };
}
