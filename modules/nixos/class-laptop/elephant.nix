{ pkgs, ... }:
{
  services.elephant = {
    enable = true;
    package = pkgs.elephant.override {
      enabledProviders = [
        "calc"
        "desktopapplications"
        "menus"
        "providerlist"
        "symbols"
        "unicode"
      ];
    };
  };
  systemd.user.services.elephant.serviceConfig.Environment =
    "PATH=/run/wrappers/bin:%h/.nix-profile/bin:/run/current-system/sw/bin:/etc/profiles/per-user/%u/bin";
}
