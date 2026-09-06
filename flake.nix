{
  description = "Nixos config flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    # Optional: a second nixpkgs revision
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix/release-25.11";
      # url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
    alejandra.url = "github:kamadorueda/alejandra/4.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    unstable-nixpkgs,
    home-manager,
    nixos-hardware,
    nixos-raspberrypi,
    alejandra,
    stylix,
    sops-nix,
    ...
  } @ inputs: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          unstablePkgs = import unstable-nixpkgs {
            system = "x86_64-linux";
          };
          hostConfigName = "desktop"; # Defining hostname to allow users to install per-host
        };

        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              unstablePkgs = import unstable-nixpkgs {
                system = "x86_64-linux";
              };
            };
          }

          # Host Files
          ./hosts/desktop/configuration.nix
          ./hosts/desktop/hardware-configuration.nix

          # Nix Logic
          inputs.stylix.nixosModules.stylix
          ./nix-logic/common.nix

          # Users
          ./home/users/jo
          ./home/users/katharina
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          unstablePkgs = import unstable-nixpkgs {
            system = "x86_64-linux";
          };
          hostConfigName = "laptop"; # Defining hostname to allow users to install per-host
        };

        modules = [
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              unstablePkgs = import unstable-nixpkgs {
                system = "x86_64-linux";
              };
            };
          }
          # Host Files
          ./hosts/laptop/configuration.nix
          ./hosts/laptop/hardware-configuration.nix

          # Nix Logic
          inputs.stylix.nixosModules.stylix
          ./nix-logic/common.nix

          # Users
          ./home/users/jo
          ./home/users/katharina
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
          ./home/users/jo
        ];
      };
    };
  };
}
