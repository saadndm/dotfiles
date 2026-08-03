let
  bridgesense-carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/d7OFtA/pezFtl4jKHx/jmoyJsafli18bO1gAq1wtM";
  bridgesense-boron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPF+GzRmmVC0gC4apoKIrEf2DKK3bnKJLm91816oFMB+";
  bridgesense-helium = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMaV+mrXnTU7RVQNYfn7Duj4OgT6HJA1Hw6C3/d0I3wE";
  users = [
    bridgesense-carbon
    bridgesense-boron
    bridgesense-helium
  ];

  carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1oEpy8yhDJbBkozmjjN/HO2oGxnxwZqXlXFlSpwnHW root@carbon";
  boron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINpuVFaaTOyk33lJYrFDiTr3oODr2VoZ750Y7K2fVdwu root@boron";
  helium = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAbTIYV6LKWD8Gp/Mxav3jXs/WLxgnHmGXQTurNSXt3u root@helium";
  systems = [
    carbon
    boron
    helium
  ];
in
{
  "login.age".publicKeys = users ++ systems;
  "tailscale.age".publicKeys = users ++ systems;
  "vaultwarden.age".publicKeys = users ++ systems;
  "cloudflare.age".publicKeys = users ++ systems;
  "cloudflared-carbon.age".publicKeys = users ++ systems;
  "wakapi-salt.age".publicKeys = users ++ systems;
  "password.age".publicKeys = users ++ systems;
  "beszel-env.age".publicKeys = users ++ systems;
  "kopia.age".publicKeys = users ++ systems;
  "rustfs-env.age".publicKeys = users ++ systems;
}
