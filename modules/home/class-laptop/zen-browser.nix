{ inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    enable = true;
    profiles.BridgeSense = {
      isDefault = true;
      name = "BridgeSense";
      settings = {
        browser = {
          urlbar.maxRichResults = 10;
          urlbar.maxHistoricalSearchSuggestions = 4;
          ctrlTab.sortByRecentlyUsed = true;
        };
        zen = {
          workspaces.continue-where-left-off = true;
          theme.gradient.show-custom-colors = true;
          pinned-tab-manager.restore-pinned-tabs-to-pinned-url = true;
        };
        gfx.webrender.all = true;
        widget.use-xdg-desktop-portal.file-picker = 1;
      };
      userChrome = ''
        #urlbar-results {
          max-height: min(65vh, 520px) !important;
        }

        #urlbar[open][zen-floating-urlbar="true"] {
          top: 15.6vh !important;
        }
      '';
      keyboardShortcuts = [
        {
          id = "zen-compact-mode-show-sidebar";
          key = "x";
          modifiers = {
            alt = true;
          };
        }
        {
          id = "zen-compact-mode-toggle";
          key = "c";
          modifiers = {
            alt = true;
          };
        }
        {
          id = "zen-workspace-backward";
          key = "a";
          modifiers = {
            alt = true;
          };
        }
        {
          id = "zen-workspace-forward";
          key = "s";
          modifiers = {
            alt = true;
          };
        }
        {
          id = "manBookmarkKb";
          disabled = true;
        }
        {
          id = "key_inspector";
          disabled = true;
        }
      ];
    };
    policies = {
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
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
}
