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

  extraPackages = with pkgs; [
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
    golangci-lint

    clang-tools

    haskell-language-server
    ormolu
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
      nvim-lint

      blink-cmp
      colorful-menu-nvim
      blink-indent

      snacks-nvim
      lazydev-nvim
      trouble-nvim
      todo-comments-nvim

      mini-nvim

      fff-nvim

      vim-wakatime

      tiny-cmdline-nvim
      tiny-inline-diagnostic-nvim

      nvim-jump

      lazygit-nvim

      SchemaStore-nvim

      typst-preview-nvim
      # markview-nvim
      obsidian-nvim
    ];
  };
}
