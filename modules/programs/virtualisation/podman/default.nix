{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    podman-compose
  ];
  # Enable common container config files in /etc/containers
  virtualisation = {
    oci-containers.backend = "podman";
    containers.enable = true;
    podman = {
      enable = true;

      autoPrune = {
        enable = true;
      };
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
