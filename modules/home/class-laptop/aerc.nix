{ config, ... }:
{
  programs.aerc = {
    enable = true;

    extraConfig = {
      general.unsafe-accounts-conf = true;
      filters = {
        "text/plain" = "colorize";
        "text/html" = "html";
        "text/calendar" = "calendar";
        "message/delivery-status" = "colorize";
        "message/rfc822" = "colorize";
      };
    };
  };

  accounts.email.accounts = {
    Personal = {
      primary = true;
      aerc.enable = true;

      realName = "Saad Nadeem";
      address = "bridgesensemc@gmail.com";
      userName = "bridgesensemc@gmail.com";

      imap.host = "imap.gmail.com";
      smtp.host = "smtp.gmail.com";

      passwordCommand = "cat ${config.age.secrets.bridgesensemc-gmail.path}";

      folders = {
        inbox = "INBOX";
        drafts = "[Gmail]/Drafts";
        sent = "[Gmail]/Sent Mail";
        trash = "[Gmail]/Trash";
      };
    };

    Secondary = {
      aerc.enable = true;

      realName = "Saad Nadeem";
      address = "saad29nadeem@gmail.com";
      userName = "saad29nadeem@gmail.com";

      imap.host = "imap.gmail.com";
      smtp.host = "smtp.gmail.com";

      passwordCommand = "cat ${config.age.secrets.saad29nadeem-gmail.path}";

      folders = {
        inbox = "INBOX";
        drafts = "[Gmail]/Drafts";
        sent = "[Gmail]/Sent Mail";
        trash = "[Gmail]/Trash";
      };
    };

    UWaterloo = {
      aerc = {
        enable = true;
        imapAuth = "xoauth2";
        smtpAuth = "xoauth2";
      };

      realName = "Saad Nadeem";
      address = "s39nadee@uwaterloo.ca";
      userName = "s39nadee@uwaterloo.ca";

      imap = {
        host = "outlook.office365.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.office365.com";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };

      passwordCommand = "oama access s39nadee@uwaterloo.ca";
      folders = {
        inbox = "INBOX";
        drafts = "Drafts";
        sent = "Sent Items";
        trash = "Trash";
      };
    };
  };
}
