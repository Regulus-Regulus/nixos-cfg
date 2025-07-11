{ pkgs, lib, config, ... }:

{
  homeSettings = {
    home = {
      username = "jo";
      homeDirectory = "/home/jo";
      stateVersion = "24.11";

      packages = with pkgs; [
        # hier eigene Pakete hinzufügen
      ];
    };
    programs.fish.enable = true;
    programs.zsh = {
      enable = true;
      # Overrides und Ergänzungen zum Default:
      shellAliases = {
        # z.B. eigene Aliase, die zum Default hinzukommen
        ll = "${pkgs.eza}/bin/eza -lha --icons=auto";
        ls = "${pkgs.eza}/bin/eza -1 --icons=auto";
      };
      oh-my-zsh.plugins = lib.mkForce [
        "docker"  # zusätzlich zum Default "git", "gitignore", "z"
      ];
    };

    programs.home-manager.enable = true;
  };

  systemSettings = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
  };
}



# { pkgs, config, ... }:

# {
#   homeSettings = {
#     home = {
#       username = "jo";
#       homeDirectory = "/home/jo";
#       stateVersion = "24.11";

#       packages = with pkgs; [
#       ];
#     };
#     programs.home-manager.enable = true;
#     programs.zsh.enable = true;

#   };

#   systemSettings = {
#     isNormalUser = true;
#     shell = pkgs.zsh;
#     extraGroups = [ "wheel" ];
#   };
# }