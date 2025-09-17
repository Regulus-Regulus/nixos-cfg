{
  self,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [pkgs.librewolf];

  home-manager.sharedModules = [
    (_: {
      programs.firefox = {
        enable = true;
        package = pkgs.librewolf;
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
            # BitWarden Password Manager
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/file/4567044/bitwarden_password_manager-2025.8.2.xpi";
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
            "browser.urlbar.suggest.bookmark" = false;
            "browser.urlbar.suggest.engines" = false;
            "browser.urlbar.suggest.history" = false;
            "browser.urlbar.suggest.openpage" = false;
            "browser.urlbar.suggest.recentsearches" = false;
            "browser.urlbar.suggest.topsites" = false;
            "browser.warnOnQuit" = false;
            "browser.warnOnQuitShortcut" = false;
            "places.history.enabled" = "false";
            "privacy.resistFingerprinting" = true;
            "privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts" = true;
          };
        };
      };
    })
  ];
}
