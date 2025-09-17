{
  ...
}:
{
  programs.git = {
    enable = true;
    userName = "Saad Nadeem";
    userEmail = "saad29nadeem@gmail.com";
    extraConfig = {
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
    };
  };
}
