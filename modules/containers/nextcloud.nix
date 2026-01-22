{pkgs, ...}: {
  virtualisation.podman.enable = true;

  virtualisation.oci-containers.backend = "podman";

  virtualisation.oci-containers.containers = {
    nextcloud = {
      image = "docker.io/library/nextcloud:apache";
      autoStart = true;

      ports = [
        "127.0.0.1:8080:80"
      ];

      volumes = [
        "/var/lib/nextcloud/html:/var/www/html"
      ];
      environment = {
        POSTGRES_HOST = "postgres";
        POSTGRES_DB = "nextcloud";
        POSTGRES_USER = "nextcloud";
        POSTGRES_PASSWORD = "changeme";
      };

      dependsOn = ["postgres"];
    };
    postgres = {
      image = "docker.io/library/postgres:16";
      autoStart = true;

      environment = {
        POSTGRES_DB = "nextcloud";
        POSTGRES_USER = "nextcloud";
        POSTGRES_PASSWORD = "changeme";
      };

      volumes = [
        "/var/lib/nextcloud/db:/var/lib/postgresql/data"
      ];
    };
  };
}
