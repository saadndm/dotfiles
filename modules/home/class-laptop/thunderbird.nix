{ pkgs, ... }:
let
  tbkeys = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "tbkeys";
    version = "2.4.3";
    src = pkgs.fetchurl {
      url = "https://github.com/wshanks/tbkeys/releases/download/v${version}/tbkeys.xpi";
      hash = "sha256-2e+T5Nr5kc2s8EykFzWKaJZ2jPUDHh9Cqn4hCuDCLaM=";
    };
    dontUnpack = true;
    installPhase = ''
      install -Dm644 $src \
        $out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/tbkeys@addons.thunderbird.net.xpi
    '';
  };
  betterunsubscribe = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "betterunsubscribe";
    version = "2.9.1";
    src = pkgs.fetchurl {
      url = "https://addons.thunderbird.net/thunderbird/downloads/file/1046526/betterunsubscribe-${version}-tb.xpi";
      hash = "sha256-QA4zeHj1Ht1sXn6ySyUqs3/cN6mKpiKsPNgD15Yzd6A=";
    };
    dontUnpack = true;
    installPhase = ''
      install -Dm644 $src \
        $out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/{4753278b-acea-4b2b-a111-1fc9450d239d}.xpi
    '';
  };
in
{
  accounts.email.accounts = {
    Saad = {
      primary = true;
      address = "saadndm.sn@gmail.com";
      userName = "saadndm.sn@gmail.com";
      realName = "Saad Nadeem";
      flavor = "gmail.com";
      thunderbird.enable = true;
    };
    BridgeSense = {
      address = "bridgesensemc@gmail.com";
      userName = "bridgesensemc@gmail.com";
      realName = "Saad Nadeem";
      flavor = "gmail.com";
      thunderbird.enable = true;
    };
    School = {
      address = "saad.nadeem@uwaterloo.ca";
      userName = "s39nadee@uwaterloo.ca";
      realName = "Saad Nadeem";
      flavor = "outlook.office365.com";
      thunderbird.enable = true;
      thunderbird.settings = id: {
        "mail.server.server_${id}.authMethod" = 10;
        "mail.smtpserver.smtp_${id}.authMethod" = 10;

        "mail.server.server_${id}.trash_folder_name" = "Deleted Items";
      };
      thunderbird.perIdentitySettings = id: {
        "mail.identity.id_${id}.archive_granularity" = 0;

        "mail.identity.id_${id}.fcc_folder_picker_mode" = "1";
        "mail.identity.id_${id}.fcc_folder" =
          "imap://s39nadee%40uwaterloo.ca@outlook.office365.com/Sent%20Items";

        "mail.identity.id_${id}.drafts_folder_picker_mode" = "1";
        "mail.identity.id_${id}.draft_folder" =
          "imap://s39nadee%40uwaterloo.ca@outlook.office365.com/Drafts";

        "mail.identity.id_${id}.archive_folder_picker_mode" = "1";
        "mail.identity.id_${id}.archive_folder" =
          "imap://s39nadee%40uwaterloo.ca@outlook.office365.com/Archive";
      };
    };
  };
  programs = {
    thunderbird = {
      enable = true;
      profiles = {
        default = {
          isDefault = true;
          extensions = [
            tbkeys
            betterunsubscribe
          ];
        };
      };
      settings = {
        "general.useragent.override" = "";
        "extensions.autoDisableScopes" = 0;
        "extensions.experiments.enabled" = true;
        "xpinstall.signatures.required" = false;
        "mail.shell.checkDefaultClient" = false;
        "privacy.donottrackheader.enabled" = true;
        "mail.chat.enabled" = false;
      };
    };
  };
}
