{
  self,
  pkgs,
  ...
}: {
  programs.firefox.enable = true;

  home-manager.sharedModules = [
    (_: {
      programs.firefox = {
        enable = true;

        policies = {
          DisablePocket = true;
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          PasswordManagerEnabled = false;
          FirefoxHome = {
            Pocket = false;
            Snippets = false;
          };
        };

        profiles.default = {
          id = 0;
          name = "default";

          settings = {
            # Search Engine
            "browser.search.defaultenginename" = "Ecosia";
            "browser.search.selectedEngine" = "Ecosia";
            "browser.search.update" = false;

            # Privacy & Tracking
            "privacy.donottrackheader.enabled" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
            "privacy.trackingprotection.cryptomining.enabled" = true;
            # Breaks firefox sync login flow
            "privacy.trackingprotection.fingerprinting.enabled" = false;
            "privacy.partition.network_state.ocsp_cache" = true;

            # HTTPS-Only Mode
            "dom.security.https_only_mode" = true;

            # Disable telemetry
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.updatePing.enabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;

            # Disable studies, normandy
            "app.shield.optoutstudies.enabled" = false;
            "app.normandy.enabled" = false;
            "app.normandy.api_url" = "";

            # Disable autofill (optional)
            "signon.rememberSignons" = false;
            "signon.autofillForms" = false;

            # UI noise removal
            "browser.newtabpage.activity-stream.feeds.snippets" = false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "extensions.pocket.enabled" = false;
            "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;

            # Resist fingerprinting (some breakage possible)
            "privacy.resistFingerprinting" = true;

            # Disable geolocation prompts
            "geo.enabled" = false;

            # Disable webRTC IP leakage
            "media.peerconnection.ice.default_address_only" = true;
            "media.peerconnection.ice.no_host" = true;
          };
        };
      };
    })
  ];
}
