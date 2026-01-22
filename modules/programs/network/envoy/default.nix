{
  self,
  pkgs,
  config,
  ...
}: {
  services.envoy = {
    enable = true;
    settings = {
      admin = {
        access_log_path = "/dev/null";
        address = {
          socket_address = {
            protocol = "TCP";
            address = "127.0.0.1";
            port_value = 9901;
          };
        };
      };
      static_resources = {
        listeners = [];
        clusters = [];
      };
    };
  };
}
