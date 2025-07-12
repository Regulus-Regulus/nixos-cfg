{
  config,
  pkgs,
  ...
}: let
  # Script-Inhalt als Text
  nixGcScript = ''
    #!${pkgs.bash}/bin/bash
    ${pkgs.nix}/bin/nix-collect-garbage -d
  '';
in {
  environment.etc."nix-gc-shutdown.sh".text = nixGcScript;

  systemd.services.nix-gc-shutdown = {
    description = "Nix Garbage Collection on shutdown";
    wantedBy = ["shutdown.target"];
    before = ["shutdown.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/etc/nix-gc-shutdown.sh";
      TimeoutStartSec = 0;
    };
  };
}
