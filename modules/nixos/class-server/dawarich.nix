{ ... }:
{
  services.dawarich = {
    enable = true;
    localDomain = "dawarich.saadndm.com";
    configureNginx = false;
    webPort = 4000;
  };
}
