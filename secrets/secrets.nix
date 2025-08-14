let
  bridgesense-carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/d7OFtA/pezFtl4jKHx/jmoyJsafli18bO1gAq1wtM";
  bridgesense-boron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPBxnA3Ba+Nocy0sX4Vjm0l0WtvK/H2O03ehTIf+gA9D";
  users = [
    bridgesense-carbon
    bridgesense-boron
  ];

  carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1oEpy8yhDJbBkozmjjN/HO2oGxnxwZqXlXFlSpwnHW root@carbon";
  boron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINX2yLIqU+IjEygB64hmnRai/sNdok/Is80QBc8QmlLG root@boron";
  systems = [
    carbon
    boron
  ];
in
{
  "password.age".publicKeys = users ++ systems;
  "tailscale.age".publicKeys = users ++ systems;
}
