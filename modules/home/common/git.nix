_: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Saad Nadeem";
        email = "saadndm.sn@gmail.com";
      };
      init.defaultBranch = "main";
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
      pull = {
        rebase = true;
      };
      rebase = {
        autoStash = true;
      };
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
    };
  };
}
