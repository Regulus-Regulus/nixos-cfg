{
  config,
  pkgs,
  ...
}: let
  nixGcScript = ''
    #!${pkgs.bash}/bin/bash
    ${pkgs.nix}/bin/nix-collect-garbage --delete-older-than +10
  '';
in {
  environment.etc."nix-gc-shutdown.sh".text = nixGcScript;

  systemd.services.nix-gc-shutdown = {
    description = "Run nix garbage collection before shutdown";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/etc/nix-gc-shutdown.sh";
      TimeoutStartSec = 0;
      DefaultDependencies = false;
      Before = ["shutdown.target"];
      Conflicts = ["shutdown.target"]; # This ensures it runs before shutdown takes hold
    };
    wantedBy = ["shutdown.target"]; # This covers all types of shutdown, including desktop logout, etc.
  };
}
