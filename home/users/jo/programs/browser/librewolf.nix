{
  self,
  pkgs,
  lib,
  config,
  unstablePkgs,
  ...
}:
with lib; let
  cfg = config.jo.home.programs.browser.librewolf;
in {
  options.jo.home.programs.browser.librewolf = {
    enable = mkEnableOption "Enable opinionated librewolf setup";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = unstablePkgs.librewolf;
      policies = {
        Cookies = {
          "Allow" = [
            "https://github.com"
          ];
          "Locked" = true;
        };
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        ExtensionSettings = {
          # Ecosia
          "{d04b0b40-3dab-4f0b-97a6-04ec3eddbfb0}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4519632/ecosia_the_green_search-latest.xpi";
            installation_mode = "force_installed";
          };
          # BitWarden Password Manager
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4567044/bitwarden_password_manager-latest.xpi";
            installation_mode = "force_installed";
          };
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
        };
        FirefoxHome = {
          "Search" = false;
        };
        HardwareAcceleration = true;
        Preferences = {
          "browser.preferences.defaultPerformanceSettings.enabled" = false;
          "browser.startup.homepage" = "about:home";
          "browser.toolbar.bookmarks.visibility" = "newtab";
          "browser.toolbars.bookmarks.visibility" = "newtab";
          "browser.urlbar.suggest.bookmark" = true;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.history" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.recentsearches" = true;
          "browser.urlbar.suggest.topsites" = false;
          "browser.warnOnQuit" = false;
          "browser.warnOnQuitShortcut" = false;
          "places.history.enabled" = "false";
          "privacy.resistFingerprinting" = true;
          "privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts" = true;
        };
      };
    };
  };
}
