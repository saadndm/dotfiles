{
  inputs,
  config,
  ...
}:
{
  imports = [
    "${inputs.kopia}/nixos/modules/services/backup/kopia"
  ];

  services.kopia.backups.carbon-backup = {
    repositoryType = "s3";
    s3 = {
      bucket = "backups";
      endpoint = "rustfs-carbon.saadndm.com";
    };

    passwordFile = config.age.secrets.password.path;
    environmentFile = config.age.secrets.kopia-env.path;

    paths = [
      "/var/lib/immich"
      "/var/lib/dawarich"
      "/var/lib/papra"
      "/var/lib/postgresql"
      "/var/lib/wakapi"
      "/var/lib/actual"
      "/var/lib/vaultwarden"
      "/home/bridgesense/dotfiles"
      "/home/bridgesense/Projects"
    ];

    policy = {
      files = {
        ignore = [
          "!*.db"
          "!*.db-shm"
          "!*.db-wal"
        ];
        ignoreDotFiles = [ ".gitignore" ];
      };
      retention = {
        keepDaily = 7;
        keepWeekly = 4;
        keepMonthly = 6;
      };
    };

    web = {
      enable = true;
      address = "0.0.0.0:51515";
      serverUsername = "kopia";
      serverPasswordFile = config.age.secrets.password.path;
    };

    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}
