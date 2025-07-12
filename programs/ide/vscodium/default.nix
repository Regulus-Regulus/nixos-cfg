{
  self,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Uncomment one of these to install VS Code system-wide
    # vscode    # Official Microsoft build (requires unfree = true)
    vscodium # Telemetry-free community build
  ];

  #nixpkgs.config.allowUnfree = true; # Needed if using vscode

  # Home Manager shared modules (user-level config)
  home-manager.sharedModules = [
    (_: {
      programs.vscode = {
        enable = true;

        # Choose which VS Code package to use:
        package = pkgs.vscodium; # Telemetry-free (recommended)
        # package = pkgs.vscode;   # Official MS build (has telemetry)

        # Extensions to install automatically
        profiles.default.extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
        ];

        # VS Code user settings.json overrides
        profiles.default.userSettings = {
          "editor.fontFamily" = "Fira Code, monospace";
          "editor.fontLigatures" = true;
          "editor.tabSize" = 4;
          "files.autoSave" = "onFocusChange";
          "telemetry.enableTelemetry" = false;
          "telemetry.enableCrashReporter" = false;
        };

        # Optional keybindings overrides
        # keybindings = [
        #   {
        #     key = "ctrl+s";
        #     command = "workbench.action.files.save";
        #   }
        # ];
      };
    })
  ];
}
