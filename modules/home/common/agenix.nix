{
  inputs,
  ...
}:
{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  age = {
    identityPaths = [ "/home/bridgesense/.ssh/id_ed25519" ];
    secrets = {
      bridgesensemc-gmail = {
        file = ../../../secrets/bridgesensemc-gmail.age;
      };
      saad29nadeem-gmail = {
        file = ../../../secrets/saad29nadeem-gmail.age;
      };
    };
  };
}
