{ config, pkgs, ... }:
{
  systemd.services.fail2ban.serviceConfig.EnvironmentFile = config.age.secrets.cloudflare.path;

  environment.etc."fail2ban/action.d/cloudflare-nixos.conf".text = ''
    [Definition]

    actionstart =
    actionstop =
    actioncheck =

    actionban = curl -s -X POST "<_cf_api_url>" <_cf_api_prms> --data '{"mode":"<cfmode>","configuration":{"target":"<cftarget>","value":"<ip>"},"notes":"<notes>"}'

    actionunban = json=$(curl -s -X GET "<_cf_api_url>?per_page=1000" <_cf_api_prms>); \
                  id=$(echo "$json" | jq -r --arg ip "<ip>" '.result[] | select(.configuration.value==$ip) | .id' | head -n1); \
                  if [ -z "$id" ] || [ "$id" = "null" ]; then exit 0; fi; \
                  curl -v -X DELETE "<_cf_api_url>/$id" <_cf_api_prms> --data '{"cascade":"none"}';

    _cf_api_url = https://api.cloudflare.com/client/v4/zones/<cfzone>/firewall/access_rules/rules
    _cf_api_prms = -H "Authorization: Bearer ''${CLOUDFLARE_API_TOKEN}" -H "Content-Type: application/json"

    [Init]
    cftarget = ip
    cfmode = block
    notes = Fail2Ban <name>

    [Init?family=inet6]
    cftarget = ip6
  '';

  environment.etc = {
    "fail2ban/filter.d/vaultwarden.local".text = ''
      [INCLUDES]
      before = common.conf

      [Definition]
      failregex = ^.*Username or password is incorrect\. Try again\. IP: <HOST>\. Username:.*$
      ignoreregex =
    '';

    "fail2ban/filter.d/vaultwarden-admin.local".text = ''
      [INCLUDES]
      before = common.conf

      [Definition]
      failregex = ^.*Invalid admin token\. IP: <HOST>.*$
      ignoreregex =
    '';

    "fail2ban/filter.d/vaultwarden-totp.local".text = ''
      [INCLUDES]
      before = common.conf

      [Definition]
      failregex = ^.*Invalid TOTP code! Server time: .* UTC IP: <HOST>$
      ignoreregex =
    '';
  };

  services.fail2ban = {
    enable = true;
    extraPackages = [
      pkgs.curl
      pkgs.jq
    ];
    maxretry = 5;
    bantime = "10m";
    banaction = "iptables-multiport";
    banaction-allports = "iptables-allports";
    bantime-increment = {
      enable = true;
      multipliers = "1 2 4 8 16 32";
      maxtime = "168h";
      overalljails = true;
    };
    jails = {
      vaultwarden.settings = {
        enabled = true;
        filter = "vaultwarden";
        logpath = "/var/lib/vaultwarden/access.log";
        backend = "auto";
        port = "80,443";
        findtime = "15m";
        action = "cloudflare-nixos[cfzone=49bde92f7434b36009d745625aff15a2] iptables-allports";
      };

      vaultwarden-admin.settings = {
        enabled = true;
        filter = "vaultwarden-admin";
        logpath = "/var/lib/vaultwarden/access.log";
        backend = "auto";
        port = "80,443";
        findtime = "15m";
        action = "cloudflare-nixos[cfzone=49bde92f7434b36009d745625aff15a2] iptables-allports";
      };

      vaultwarden-totp.settings = {
        enabled = true;
        filter = "vaultwarden-totp";
        logpath = "/var/lib/vaultwarden/access.log";
        backend = "auto";
        port = "80,443";
        findtime = "15m";
        action = "cloudflare-nixos[cfzone=49bde92f7434b36009d745625aff15a2] iptables-allports";
      };
    };
  };
}
