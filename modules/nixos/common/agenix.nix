{
  inputs,
  ...
}:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  age = {
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
      login = {
        file = ../../../secrets/login.age;
      };
      tailscale = {
        file = ../../../secrets/tailscale.age;
      };
      cloudflared-carbon = {
        file = ../../../secrets/cloudflared-carbon.age;
      };
      password = {
        file = ../../../secrets/password.age;
      };
      cloudflare = {
        file = ../../../secrets/cloudflare.age;
      };
      wakapi-salt = {
        file = ../../../secrets/wakapi-salt.age;
      };
    };
  };
}
