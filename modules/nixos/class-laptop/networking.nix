{ ... }:
{
  networking.useNetworkd = true;

  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    fallbackDns = [
      "8.8.8.8"
      "1.1.1.1"
    ];
  };

  networking = {
    wireless.iwd = {
      enable = true;
      settings = {
        Settings = {
          AutoConnect = true;
        };
      };
    };
    firewall = rec {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };

  };
}
