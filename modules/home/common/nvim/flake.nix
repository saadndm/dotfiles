{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    nvim-treesitter-main = {
      url = "github:iofq/nvim-treesitter-main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixCats,
      ...
    }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = ./.;
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      extra_pkg_config = {
        allowUnfree = true;
      };
      dependencyOverlays = [
        (utils.standardPluginOverlay inputs)

        inputs.neovim-nightly-overlay.overlays.default

        inputs.nvim-treesitter-main.overlays.default

        (final: prev: {
          vimPlugins = prev.vimPlugins.extend (
            f: p: {
              nvim-treesitter = p.nvim-treesitter.withAllGrammars;
              nvim-treesitter-context = p.nvim-treesitter-context.overrideAttrs {
                dependencies = [ f.nvim-treesitter ];
              };
              nvim-treesitter-textobjects = p.nvim-treesitter-textobjects.overrideAttrs {
                dependencies = [ f.nvim-treesitter ];
              };
            }
          );
        })
      ];

      categoryDefinitions =
        {
          pkgs,
          ...
        }:
        {
          lspsAndRuntimeDeps = {
            general = with pkgs; [
              emmylua-ls

              nixd
              nixfmt

              gopls
              golangci-lint

              ruff
              basedpyright

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
            ];
          };

          startupPlugins = {
            lze = with pkgs.vimPlugins; [
              lze
              lzextras
            ];
            general = with pkgs.vimPlugins; {
              always = [
                nui-nvim
                plenary-nvim
              ];
              extra = [
                fzf-lua
                oil-nvim
                SchemaStore-nvim
                fff-nvim
                nvim-web-devicons
                vim-wakatime
                snacks-nvim
                blink-pairs
                blink-indent
              ];
            };
            treesitter = with pkgs.vimPlugins; [
              nvim-treesitter
              nvim-treesitter-context
              nvim-treesitter-textobjects
            ];
            themer = with pkgs.vimPlugins; [
              catppuccin-nvim
            ];
          };

          optionalPlugins = {
            general = {
              blink = with pkgs.vimPlugins; [
                blink-cmp
                colorful-menu-nvim
              ];
              mini = with pkgs.vimPlugins; [
                mini-nvim
              ];
              noice = with pkgs.vimPlugins; [
                noice-nvim
              ];
              typst-preview = with pkgs.vimPlugins; [
                typst-preview-nvim
              ];
              flash = with pkgs.vimPlugins; [
                flash-nvim
              ];
              trouble = with pkgs.vimPlugins; [
                trouble-nvim
              ];
              tiny-inline-diagnostic = with pkgs.vimPlugins; [
                tiny-inline-diagnostic-nvim
              ];
            };
            gitPlugins = with pkgs.vimPlugins; [
              gitsigns-nvim
              lazygit-nvim
            ];
            format = with pkgs.vimPlugins; [
              conform-nvim
            ];
            lint = with pkgs.vimPlugins; [
              nvim-lint
            ];
          };

          sharedLibraries = { };

          environmentVariables = { };

          python3.libraries = { };

          extraLuaPackages = { };
        };

      packageDefinitions = {
        nvim =
          { pkgs, ... }:
          {
            settings = {
              suffix-path = true;
              suffix-LD = true;
              wrapRc = false;
              unwrappedCfgPath = utils.mkLuaInline "os.getenv('HOME') .. '/dotfiles/modules/home/common/nvim'";
              aliases = [ "vim" ];
              neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
            };
            categories = {
              lze = true;
              treesitter = true;
              general = true;
              gitPlugins = true;
              format = true;
              lint = true;
              themer = true;
            };
          };
      };
      defaultPackageName = "nvim";
    in

    forEachSystem (
      system:
      let
        nixCatsBuilder = utils.baseBuilder luaPath {
          inherit
            nixpkgs
            system
            dependencyOverlays
            extra_pkg_config
            ;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        packages = utils.mkAllWithDefault defaultPackage;

        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [ defaultPackage ];
            inputsFrom = [ ];
            shellHook = '''';
          };
        };

      }
    )
    // (
      let
        nixosModule = utils.mkNixosModules {
          moduleNamespace = [ defaultPackageName ];
          inherit
            defaultPackageName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extra_pkg_config
            nixpkgs
            ;
        };
        homeModule = utils.mkHomeModules {
          moduleNamespace = [ defaultPackageName ];
          inherit
            defaultPackageName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extra_pkg_config
            nixpkgs
            ;
        };
      in
      {
        overlays = utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions defaultPackageName;

        nixosModules.default = nixosModule;
        homeModules.default = homeModule;

        inherit utils nixosModule homeModule;
        inherit (utils) templates;
      }
    );
}
