{
  self,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.my.programs.evergreens;
in {
  options.my.programs.evergreens = {
    enable = mkEnableOption "Enable opinionated general programs setup";
  };
  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      neovim # text-editor
      git # git!
      ripgrep # Better grep
      ripgrep-all #ripgrep, but also searches pdfs, office, ebooks etc
      htop # System metrics
      fd # Better find
      bat # Better cat
      eza # better ls
      hyperfine # Benchmarking tool
      fselect # find with SQL queries
      wiki-tui # wikipedfia text user interface
      presenterm # terminal slide-show-tool
      alejandra # nix code reformatting
      kitty # terminal
    ];
    programs.zsh.enable = true;
    programs.fish.enable = true;
  };
}
