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
      vaultwarden = {
        file = ../../../secrets/vaultwarden.age;
      };
      cloudflare = {
        file = ../../../secrets/cloudflare.age;
      };
      wakapi-salt = {
        file = ../../../secrets/wakapi-salt.age;
      };
      password = {
        file = ../../../secrets/password.age;
        owner = "bridgesense";
      };
      beszel-env = {
        file = ../../../secrets/beszel-env.age;
      };
      kopia-env = {
        file = ../../../secrets/kopia-env.age;
      };
    };
  };
}
