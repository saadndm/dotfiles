{
  config,
  lib,
  inputs,
  ...
}:
let
  kopiaModulePath = "${inputs.kopia}/nixos/modules/services/backup/kopia";

  mkSnapshot = path: {
    inherit path;
    timer.enable = true;
    timer.options = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
in
{
  imports = [
    "${kopiaModulePath}"
    "${kopiaModulePath}/repository-service.nix"
    "${kopiaModulePath}/snapshot-service.nix"
    "${kopiaModulePath}/policy-service.nix"
    "${kopiaModulePath}/web-service.nix"
  ];

  config = lib.mkIf (config.networking.hostName == "carbon") {
    services.kopia.backups.carbon-backup = {
      repository.s3 = {
        bucket = "backups";
        endpoint = "rustfs-carbon.saadndm.com";
        accessKeyIdFile = config.age.secrets.kopia.path;
        secretAccessKeyFile = config.age.secrets.kopia.path;
      };

      passwordFile = config.age.secrets.password.path;

      snapshots = lib.mapAttrs (_: path: mkSnapshot path) {
        immich = "/var/lib/immich";
        dawarich = "/var/lib/dawarich";
        papra = "/var/lib/papra";
        postgresql = "/var/lib/postgresql";
        wakapi = "/var/lib/wakapi";
        actual = "/var/lib/actual";
        vaultwarden = "/var/lib/vaultwarden";
        dotfiles = "/home/bridgesense/dotfiles";
        projects = "/home/bridgesense/Projects";
      };

      policies.entries."(global)" = {
        retention = {
          keepDaily = 7;
          keepWeekly = 4;
          keepMonthly = 6;
        };

        files = {
          ignore = [
            "!*.db"
            "!*.db-shm"
            "!*.db-wal"
          ];
          ignoreDotFiles = [ ".gitignore" ];
        };
      };

      web = {
        enable = true;
        address = "0.0.0.0:51515";
        serverUsername = "kopia";
        serverPasswordFile = config.age.secrets.password.path;
      };
    };
  };
}
