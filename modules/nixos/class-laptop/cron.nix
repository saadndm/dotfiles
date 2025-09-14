{ ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/30 * * * * /usr/bin/env bash ~/.config/scripts/burn-in.sh switch"
    ];
  };
}
