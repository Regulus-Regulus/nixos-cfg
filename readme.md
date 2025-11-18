```bash
hosts/ # contains configuration.nix and hardware-configuration.nix per host
modules/ # contains nix code for this configuration
programs/ # contains default.nix files that contain shared home-manager configurations as well as host-agnostic system configurations
users/ # contains with user-specific configurations
```

Inspiration:
https://github.com/staakman/nixos-config/blob/main/flake.nix
https://github.com/Frost-Phoenix/nixos-config/tree/main