### TODO
- Finish setting up laptop config
- optional: try out wayland
- recheck per user enabling
- move all "maybe" to their specific configs (discord)
- Figure out installation with pw set and stuff
- setup desktop host
- setup mini-pi host
multi user works, but for a fresh install, need an install script to take care of passwords etc

```bash
hosts/ # contains configuration.nix and hardware-configuration.nix per host
modules/ # contains nix code for this configuration
programs/ # contains default.nix files that contain shared home-manager configurations as well as host-agnostic system configurations
users/ # contains <user>.nix files with user-specific configurations
```

Inspiration:
https://github.com/staakman/nixos-config/blob/main/flake.nix
https://github.com/Frost-Phoenix/nixos-config/tree/main