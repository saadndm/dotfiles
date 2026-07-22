inputs:
{
  lib,
  wlib,
  pkgs,
  ...
}:
{
  imports = [ wlib.wrapperModules.neovim ];
  package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
  settings = {
    config_directory = lib.generators.mkLuaInline "os.getenv('HOME') .. '/dotfiles/modules/home/common/nvim'";
  };

  runtimePkgs = with pkgs; [
    tree-sitter

    emmylua-ls

    harper

    nixd
    nixfmt

    ruff
    ty

    typescript-go
    oxfmt
    oxlint

    tinymist
    typstyle

    gopls
    gotools

    clang-tools

    haskell-language-server
    ormolu

    rust-analyzer
    rustfmt

    vscode-json-languageserver

    bash-language-server
    shfmt

    yaml-language-server
  ];

  specs.startup = {
    # Plugins here need to be on runtimepath at startup or have no plugin/ directory
    data = with pkgs.vimPlugins; [
      catppuccin-nvim

      mini-nvim

      tiny-inline-diagnostic-nvim

      colorful-menu-nvim

      lspkind-nvim

      SchemaStore-nvim

      # TODO: Remove once lazydev fixes emmylua-ls support
      (lazydev-nvim.overrideAttrs (finalAttrs: {
        patches = [
          (pkgs.fetchpatch {
            url = "https://github.com/folke/lazydev.nvim/pull/141.patch";
            hash = "sha256-r8YZvYAT5OaY5rRdMwknaedfeWWl5PM2MRRZ9/2q51g=";
          })
        ];
      }))
    ];
  };

  specs.plugins = {
    lazy = true;
    data = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context

      nvim-lspconfig

      blink-cmp

      blink-indent

      tiny-cmdline-nvim

      pkgs.master.vimPlugins.canola-nvim

      fff-nvim

      snacks-nvim

      gitsigns-nvim
      diffview-plus-nvim

      nvim-colorizer-lua

      faster-nvim

      grug-far-nvim

      vim-wakatime

      typst-preview-nvim
      markview-nvim
      obsidian-nvim
    ];
  };
}
