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
         # Host Files
          ./hosts/laptop/configuration.nix
          ./hosts/laptop/hardware-configuration.nix
          
         # Nix Logic 
          ./modules/users.nix
          home-manager.nixosModules.home-manager
          
         # Programs
         ./home/programs/shell/zsh
           # Inline module to set selectedUsers per-host:
          {
            myUsers.selectedUsers = [ "jo" ];
          }


          ];
       };
    };
  };
}
