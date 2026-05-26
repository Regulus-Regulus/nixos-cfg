{
  self,
  pkgs,
  ...
}:
with lib; let
  cfg = config.general.system.programs.evergreens;
in {
  options.general.system.programs.evergreens = {
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
