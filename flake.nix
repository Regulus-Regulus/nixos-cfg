{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra.url = "github:kamadorueda/alejandra/4.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    stylix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
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
            myUsers.selectedUsers = ["jo" "test"];
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
    };
  };
}
