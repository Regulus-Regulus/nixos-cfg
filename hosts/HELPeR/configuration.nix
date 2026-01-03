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
    haskellPackages.gpio
    libraspberrypi
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
      address = "192.168.0.1";
      interface = "end0";
    };
    nameservers = ["1.1.1.1" "8.8.8.8" "192.168.0.1"];
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
    settings = {
      dns = {
        domainNeeded = true;
        expandHosts = true;
        upstreams = ["1.1.1.1" "8.8.8.8" "192.168.0.1"];
      };
      dhcp = {
        active = true;
        start = "192.168.0.2";
        end = "192.168.0.200";
        router = "192.168.0.1";
        leaseTime = "1d";
        ipv6 = true;
        multiDNS = true;
        hosts = [
          # Static address for the current host
          "d8:3a:dd:91:59:bb,192.168.0.244,${config.networking.hostName},infinite"
        ];
        rapidCommit = true;
      };
      misc.dnsmasq_lines = [
        # This DHCP server is the only one on the network
        "dhcp-authoritative"
        # Source: https://data.iana.org/root-anchors/root-anchors.xml
        "trust-anchor=.,38696,8,2,683D2D0ACB8C9B712A1948B27F741219298D0A450D612C483AF444A4C0FB2B16"
      ];
    };
  };

  # service to control the fan
  systemd.services.fan-control = {
    description = "Control the fan depending on the temperature";
    script = ''
      /run/current-system/sw/bin/gpio init 18 out
      temperature=$(/run/current-system/sw/bin/vcgencmd measure_temp | grep -oE '[0-9]+([.][0-9]+)?')
      threshold=65
      if /run/current-system/sw/bin/awk -v temp="$temperature" -v threshold="$threshold" 'BEGIN { exit !(temp > threshold) }'; then
        /run/current-system/sw/bin/gpio write 18 hi
      else
        /run/current-system/sw/bin/gpio write 18 lo
      fi
      /run/current-system/sw/bin/gpio close 18 out
    '';
  };

  systemd.timers.fan-control-timer = {
    description = "Run control fan script regularly";
    timerConfig = {
      OnCalendar = "*-*-* *:0/1:00"; # Run every 10 minutes
      Persistent = true;
      Unit = "fan-control.service";
    };
    wantedBy = ["timers.target"];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
