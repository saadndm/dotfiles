{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  age = {
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
      password = {
        file = ../../../secrets/password.age;
        owner = config.users.users.bridgesense.name;
      };
    };
  };
}
