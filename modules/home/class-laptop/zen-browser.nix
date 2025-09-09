{ inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    enable = true;
    profiles.BridgeSense = {
      isDefault = true;
      settings = {
        "browser.search.suggest.enabled" = true;
        "gfx.webrender.all" = true;
        "zen.workspaces.continue-where-left-off" = true;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "zen.theme.gradient.show-custom-colors" = true;
        "zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url" = true;
        "browser.startup.page" = 3;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
    policies = {
      DisableAppUpdate = true;
      BackgroundAppUpdate = false;
      DisableFeedbackCommands = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
    };
  };
  home.file.".zen/BridgeSense/zen-keyboard-shortcuts.json".source =
    "${inputs.self}/home/.zen/BridgeSense/zen-keyboard-shortcuts.json";
}
