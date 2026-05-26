{
  config,
  pkgs,
  ...
}: {
  services.loki = {
    enable = true;

    configuration = {
      auth_enabled = false;
      server.http_listen_port = 3100;

      # etc.
    };

    # or alternatively
    #configFile = ./loki-config.yaml;
  };
}
