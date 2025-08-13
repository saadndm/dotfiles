let
  bridgesense-carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINIqNZDW1FDBiRUbYMkpSZWWIx/DuRGbmCwwGfWH1/LK";
  users = [ bridgesense-carbon ];

  carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG7r5Me+QqIvxCn6qCFhX7J170tP7P6kiVN3vPSNo8qj root@carbon";
  systems = [ carbon ];
in
{
  "password.age".publicKeys = users ++ systems;
}
