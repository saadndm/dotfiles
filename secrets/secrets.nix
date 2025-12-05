let
  bridgesense-carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/d7OFtA/pezFtl4jKHx/jmoyJsafli18bO1gAq1wtM";
  bridgesense-boron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPF+GzRmmVC0gC4apoKIrEf2DKK3bnKJLm91816oFMB+";
  users = [
    bridgesense-carbon
    bridgesense-boron
  ];

  carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1oEpy8yhDJbBkozmjjN/HO2oGxnxwZqXlXFlSpwnHW root@carbon";
  boron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINpuVFaaTOyk33lJYrFDiTr3oODr2VoZ750Y7K2fVdwu root@boron";
  systems = [
    carbon
    boron
  ];
in
{
  "login.age".publicKeys = users ++ systems;
  "tailscale.age".publicKeys = users ++ systems;
  "cloudflared-carbon.age".publicKeys = users ++ systems;
  "password.age".publicKeys = users ++ systems;
  "cloudflare.age".publicKeys = users ++ systems;
  "bridgesensemc-gmail.age".publicKeys = users ++ systems;
  "saad29nadeem-gmail.age".publicKeys = users ++ systems;
  "wakatime.age".publicKeys = users ++ systems;
  "wakapi-salt.age".publicKeys = users ++ systems;
}
