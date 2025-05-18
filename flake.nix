{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    nixosConfigurations = {
     laptop = nixpkgs.lib.nixosSystem {
       specialArgs = {inherit inputs;};
       modules = [
         ./hosts/laptop/configuration.nix
         ./modules/programs/shell/zsh
	 
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.jo = { config, lib, pkgs, ... }: {
              # _module.args = { };

              # imports = [
              #   ./home/thierry.nix
              # ];
            };
           } 
         ];
       };
    };
  };
}
