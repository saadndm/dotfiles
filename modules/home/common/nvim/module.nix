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

    nixd
    nixfmt

    ruff
    ty

    typescript-go
    biome

    hyprls

    bash-language-server
    shfmt

    tinymist
    typstyle

    vscode-json-languageserver

    gotools
    gopls

    clang-tools

    haskell-language-server
    ormolu

    rust-analyzer
    rustfmt
  ];

  specs.plugins = {
    data = with pkgs.vimPlugins; [
      lze
      lzextras

      nvim-treesitter.withAllGrammars
      nvim-treesitter-context

      catppuccin-nvim

      oil-nvim
      nvim-lspconfig
      conform-nvim

      blink-cmp
      colorful-menu-nvim
      blink-indent
      blink-pairs

      snacks-nvim
      # TODO: Remove once lazydev fixes emmylua-ls support
      (lazydev-nvim.overrideAttrs (finalAttrs: {
        patches = [
          (pkgs.fetchpatch {
            url = "https://github.com/folke/lazydev.nvim/pull/141.patch";
            hash = "sha256-r8YZvYAT5OaY5rRdMwknaedfeWWl5PM2MRRZ9/2q51g=";
          })
        ];
      }))
      trouble-nvim
      todo-comments-nvim

      mini-nvim

      fff-nvim

      vim-wakatime

      tiny-cmdline-nvim
      tiny-inline-diagnostic-nvim

      nvim-jump

      lazygit-nvim
      diffs-nvim

      SchemaStore-nvim

      typst-preview-nvim
      # markview-nvim
      obsidian-nvim
    ];
  };
}
