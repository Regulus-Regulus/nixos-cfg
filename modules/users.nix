{ config, lib, pkgs, ... }:

with lib;

let
  selectedUsers = config.myUsers.selectedUsers or [];

  homeUsers = listToAttrs (map (username: {
    name = username;
    value = import ../users/${username}.nix { inherit pkgs config; };
  }) selectedUsers);

  systemUsers = listToAttrs (map (username: {
    name = username;
    value = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];  # Add more as needed
    };
  }) selectedUsers);

in {
  options.myUsers.selectedUsers = mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
    description = "Users selected for this host";
  };

  config = {
    users.users = systemUsers;

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users = homeUsers;
  };
}
