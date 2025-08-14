let
  bridgesense-carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/d7OFtA/pezFtl4jKHx/jmoyJsafli18bO1gAq1wtM";
  users = [ bridgesense-carbon ];

  carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1oEpy8yhDJbBkozmjjN/HO2oGxnxwZqXlXFlSpwnHW root@carbon";
  systems = [ carbon ];
in
{
  "password.age".publicKeys = users ++ systems;
}
