{ config, lib, pkgs, ... }:

with lib;

let
  selectedUsers = config.myUsers.selectedUsers;

  userModules = map (username:
    {
      name = username;
      value = import ../users/${username}.nix { inherit pkgs config; };
    }
  ) selectedUsers;

  homeUsers = listToAttrs (map (u: {
    name = u.name;
    value = u.value.home;
  }) userModules);

  systemUsers = listToAttrs (map (u: {
    name = u.name;
    value = u.value.system;
  }) userModules);

in {
  
  options.myUsers.selectedUsers = mkOption {
    type = types.listOf types.str;
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