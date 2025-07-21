{pkgs, ...}: {
  programs.hyfetch = {
    enable = true;
    pkgs = hyfetch;
    settings = {
    };
  };
}
