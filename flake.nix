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
          home-manager.nixosModules.home-manager
          ./modules/users.nix
            # module to set selectedUsers per-host:
          {
            myUsers.selectedUsers = [ "jo" ];
          }

          # Programs
          ./home/programs/shell/zsh
          ./home/programs/shell/fish
          ./home/programs/terminal/kitty
          ./home/programs/browser/firefox



          ];
       };
    };
  };
}
