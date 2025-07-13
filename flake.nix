{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
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
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};

        modules = [
          # Host Files
          ./hosts/laptop/configuration.nix
          ./hosts/laptop/hardware-configuration.nix

          # Nix Logic
          home-manager.nixosModules.home-manager
          ./modules/common.nix
          ./modules/users.nix
          # module to set selectedUsers per-host:
          {
            myUsers.selectedUsers = ["jo" "test"];
          }

          # Programs
          ./programs/evergreens.nix
          ./programs/shell/zsh
          ./programs/shell/fish
          ./programs/terminal/kitty
          ./programs/browser/firefox
          ./programs/media/steam
          ./programs/ide/vscodium
        ];
      };
    };
  };
}
