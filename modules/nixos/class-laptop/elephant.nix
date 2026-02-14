{ pkgs, ... }:
{
  services.elephant = {
    enable = true;
    package = pkgs.elephant.override {
      enableBitwarden = false;
      enableBluetooth = false;
      enableBookmarks = false;
      enableClipboard = false;
      enableFiles = false;
      enableNiriActions = false;
      enableNiriSessions = false;
      enableRunner = false;
      enableSnippets = false;
      enableWindows = false;
      enableTodo = false;
      enableWebsearch = false;
    };
  };
  systemd.user.services.elephant.serviceConfig.Environment =
    "PATH=%h/.nix-profile/bin:/run/current-system/sw/bin:/etc/profiles/per-user/%u/bin";
}
