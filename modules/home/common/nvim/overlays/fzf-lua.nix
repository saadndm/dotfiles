self: super: {
  vimPlugins = super.vimPlugins // {
    fzf-lua = super.vimPlugins.fzf-lua.overrideAttrs (old: {
      doCheck = false;
    });
  };
}
