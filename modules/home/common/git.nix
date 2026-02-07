{
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Saad Nadeem";
        email = "saadndm.sn@gmail.com";
      };
      init.defaultBranch = "master";
      rerere.enabled = true;
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
