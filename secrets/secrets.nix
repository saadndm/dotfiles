let
  bridgesense-carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/d7OFtA/pezFtl4jKHx/jmoyJsafli18bO1gAq1wtM";
  bridgesense-boron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbBPIqRRlC+ErWnldK2UB4yaQfyIpWm5f0epWAS/7cL";
  users = [ bridgesense-carbon bridgesense-boron];

  carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1oEpy8yhDJbBkozmjjN/HO2oGxnxwZqXlXFlSpwnHW root@carbon";
  boron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6Mb6Now3VJLj/4Fn+0yDo5v709c4vFS3tqXk0wlu/G root@boron";
  systems = [ carbon boron ];
in
{
  "password.age".publicKeys = users ++ systems;
}
