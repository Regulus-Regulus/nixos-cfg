{
  self,
  pkgs,
  config,
  ...
}: {
  services = {
    pihole-web = {
      enable = true;
      ports = [80];
    };
    pihole-ftl = {
      enable = true;
      lists = [
        {
          url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
          type = "block";
          enabled = true;
          description = "Steven Black's HOSTS";
        }
        {
          url = "https://media.githubusercontent.com/media/zachlagden/Pi-hole-Optimized-Blocklists/main/lists/all_domains.txt";
          type = "block";
          enabled = true;
          description = "Zachlagden";
        }
      ];

      openFirewallDNS = true;
      openFirewallDHCP = true;
      openFirewallWebserver = true;

      queryLogDeleter = {
        enable = true;
        age = 30;
      };
      settings = {
        misc.readOnly = true;
        webserver = {
          api = {
            # To manage the web login:
            # 1) Temporarily set misc.readOnly to false in
            #    configuration.nix and switch to it.
            # 2) Manually set a password:
            #    Pi-hole web console > Settings > All settings >
            #    Webserver and API > webserver.api.password > Value: ******
            # 3) Read the generated hash:
            #    sudo pihole-FTL --config webserver.api.pwhash
            pwhash = "$BALLOON-SHA256$v=1$s=1024,t=32$djCA85yXsVAAiewpi59rgw==$REz0pOxcl92/XYvQvyRE6WZpE197a2lYsd/ltW0SdwY=";
          };

          session = {
            timeout = 43200; # 12h
          };
        };
        # debug = {
        #   all = true;
        # };
        dns = {
          domain = "homelab.me";
          domainNeeded = true;
          expandHosts = true;
          upstreams = ["1.1.1.1" "8.8.8.8" "192.168.0.1"];
          interface = "end0";
          hosts = [
            "192.168.0.244 pihole.homelab.me"
          ];
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
  };
}
