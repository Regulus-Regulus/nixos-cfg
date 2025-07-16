{
  self,
  pkgs,
  lib,
  ...
}: let
  jonathanharty.gruvbox-material-icon-theme =
    pkgs.vscode-utils.buildVscodeMarketplaceExtension
    {
      mktplcRef = {
        name = "gruvbox-material-icon-theme";
        publisher = "JonathanHarty";
        version = "1.1.5";
        hash = "sha256-86UWUuWKT6adx4hw4OJw3cSZxWZKLH4uLTO+Ssg75gY=";
      };
    };
in {
  environment.systemPackages = with pkgs; [
    vscodium # Telemetry-free community build
  ];

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
          eamodio.gitlens
          ms-kubernetes-tools.vscode-kubernetes-tools
          tim-koehler.helm-intellisense
          redhat.vscode-yaml
          ## Color scheme
          jdinhlife.gruvbox
          jonathanharty.gruvbox-material-icon-theme
        ];

        # VS Code user settings.json overrides
        profiles.default.userSettings = {
          "editor.fontFamily" = "Fira Code, monospace";
          "editor.fontLigatures" = true;
          "editor.insertSpaces" = true;
          "editor.tabSize" = 2;
          "files.autoSave" = "onFocusChange";
          "telemetry.enableTelemetry" = false;
          "telemetry.enableCrashReporter" = false;
          "git.enableSmartCommit" = true;
          "git.confirmSync" = false;
          "git.autoFetch" = true;
          "markdown.updateLinksOnFileMove.enabled" = true;
          "explorer.confirmDragAndDrop" = false;
          "explorer.confirmDelete" = false;
          "workbench.colorTheme" = "Gruvbox Dark Hard";
          "workbench.iconTheme" = "gruvbox-material-icon-theme";
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
