{ ... }:
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
}
