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

      spacesForce = true;
      spaces = {
        "Personal" = {
          id = "4d276e5c-73af-4748-ae43-afcc16cf1dac";
          position = 1000;
          icon = "chrome://browser/skin/zen-icons/selectable/rocket.svg";
          liveFolders = {
            "Pull Requests" = {
              id = "1780796719814-35";
              kind = "github:pull-requests";
              position = 403;
              folderIcon = "chrome://browser/skin/zen-icons/selectable/logo-github.svg";
              github = {
                authorMe = true;
                assignedMe = true;
                reviewRequested = true;
              };
            };
            "Issues" = {
              id = "1780796723036-59";
              kind = "github:issues";
              position = 402;
              folderIcon = "chrome://browser/skin/zen-icons/selectable/logo-github.svg";
              github = {
                authorMe = true;
                assignedMe = true;
              };
            };
          };
        };
        "School" = {
          id = "e07a9d92-7656-4355-a370-50d4abf3094b";
          position = 2000;
          icon = "chrome://browser/skin/zen-icons/selectable/school.svg";
        };
      };

      settings = {
        "browser.shell.checkDefaultBrowser" = false;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.urlbar.maxRichResults" = 10;
        "browser.urlbar.maxHistoricalSearchSuggestions" = 4;
        "zen.workspaces.continue-where-left-off" = true;
        "zen.theme.gradient.show-custom-colors" = true;
        "zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url" = true;
        "zen.urlbar.single-toolbar-show-copy-url" = false;
        "gfx.webrender.all" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
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
