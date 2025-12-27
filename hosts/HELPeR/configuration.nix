# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  stylix,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "deadacute";
  };
  nix.settings.trusted-users = ["jo"];
  hardware.bluetooth.enable = false; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot
  # Enable CUPS to print documents.
  services.blueman.enable = true;
  # # Session-Datei für Hyprland hinzufügen (damit GDM es sieht)
  # systemd.services.hyprland-session = {
  #   description = "Hyprland Wayland Session";
  #   wantedBy = ["graphical-session.target"];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.hyprland}/bin/hyprland";
  #     Restart = "on-failure";
  #   };
  # };
  environment.systemPackages = with pkgs; [
    git # git!
    ripgrep # Better grep
    ripgrep-all #ripgrep, but also searches pdfs, office, ebooks etc
    fd # Better find
    bat # Better cat
    eza # better ls
    hyperfine # Benchmarking tool
    fselect # find with SQL queries
  ];
  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = false;
  services.pipewire = {
    enable = false;
    alsa.enable = false;
    alsa.support32Bit = false;
    pulse.enable = false;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # networking config. important for ssh!
  networking = {
    hostName = "HELPeR";
    interfaces.end0 = {
      ipv4.addresses = [
        {
          address = "192.168.0.244";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = {
      address = "192.168.0.1"; # or whichever IP your router is
      interface = "end0";
    };
  };

  services.openssh = {
    enable = true;
    # Change default Port
    ports = [7373];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
      AllowUsers = ["jo"];
    };
  };

  services.pihole-ftl = {
    enable = true;
    queryLogDeleter = {
      enable = true;
      age = 30;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
