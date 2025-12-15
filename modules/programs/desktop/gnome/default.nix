{
  self,
  pkgs,
  ...
}: {
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    # themechanger
    # gnomeExtensions.blur-my-shell
    # gnomeExtensions.just-perfection
    # gnomeExtensions.arc-menu
  ];

  environment.gnome.excludePackages = with pkgs; [
    baobab # disk usage analyzer
    # cheese # photo booth
    # eog # image viewer
    epiphany # web browser
    gedit # text editor
    #simple-scan # document scanner
    totem # video player
    yelp # help viewer
    evince # document viewer
    # file-roller # archive manager
    geary # email client
    seahorse # password manager
    # these should be self explanatory
    # gnome-calculator
    # gnome-calendar
    # gnome-characters
    # gnome-clocks
    # gnome-contacts
    # gnome-font-viewer
    # gnome-logs
    # gnome-maps
    # gnome-music
    # gnome-photos
    # gnome-screenshot
    # gnome-system-monitor
    # gnome-weather
    # gnome-disk-utility
    # pkgs.gnome-connections
  ];

  # homeSettings = {
  #   dconf = {
  #     enable = true;
  #     settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  #     # settings = {
  #     #   "org/gnome/shell" = {
  #     #     disable-user-extensions = false; # enables user extensions
  #     #     enabled-extensions = [
  #     #       # Put UUIDs of extensions that you want to enable here.
  #     #       # If the extension you want to enable is packaged in nixpkgs,
  #     #       # you can easily get its UUID by accessing its extensionUuid
  #     #       # field (look at the following example).
  #     #       pkgs.gnomeExtensions.gsconnect.extensionUuid

  #     #       # Alternatively, you can manually pass UUID as a string.
  #     #       "blur-my-shell@aunetx"
  #     #       # ...
  #     #     ];
  #     #   };

  #     #   # Configure individual extensions
  #     #   "org/gnome/shell/extensions/blur-my-shell" = {
  #     #     brightness = 0.75;
  #     #     noise-amount = 0;
  #     #   };
  #     # };
  #   };
  # };
}
