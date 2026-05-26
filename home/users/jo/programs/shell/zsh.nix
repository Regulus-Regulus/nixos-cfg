{
  self,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.jo.home.programs.shell.zsh;
in {
  options.jo.home.programs.shell.zsh = {
    enable = mkEnableOption "Enable opinionated zsh setup";
  };
  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      history = {
        size = 100000;
        path = "$HOME/.local/share/zsh/history";
      };
      dotDir = ".config/zsh";
      # initContent = ''
      #   source ${pkgs.spaceship-prompt}/share/zsh/themes/spaceship.zsh-theme;
      # '';
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "gitignore" "z"];
      };

      initContent = ''
        function rebuild() {
          ~/NixosConfiguration/scripts/rebuild.sh "$@"
        }
      '';
      shellAliases = {
        godot = "godot --rendering-driver vulkan";
      };
    };
  };
}
