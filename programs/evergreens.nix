{
  self,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # text-editor
    git # git!
    obsidian # Personal Knowledge Management, unfree, no home-manager config as of now
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
  ];
}
