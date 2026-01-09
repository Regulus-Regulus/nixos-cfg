{
  self,
  pkgs,
  ...
}: {
  services.pihole-ftl = {
    enable = true;
    openFirewallDNS = true;
    openFirewallDHCP = true;

    queryLogDeleter = {
      enable = true;
      age = 30;
    };
    settings = {
      debug = {
        all = true;
      };
      dns = {
        domainNeeded = true;
        expandHosts = true;
        upstreams = ["1.1.1.1" "8.8.8.8" "192.168.0.1"];
        interface = "end0";
      };
      dhcp = {
        active = false;
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
}
