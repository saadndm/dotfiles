{ inputs, crane, rust-overlay }:
final: prev:
let
  src = inputs.fff-nvim;
  pkgs = import inputs.nixpkgs {
    inherit (final) system;
    overlays = [ (import rust-overlay) ];
  };
  rustToolchain = pkgs.rust-bin.fromRustupToolchainFile "${src}/rust-toolchain.toml";
  craneLib = (crane.mkLib pkgs).overrideToolchain rustToolchain;
  backend = craneLib.buildPackage {
    src = src;
    strictDeps = true;
    nativeBuildInputs = [ pkgs.pkg-config pkgs.perl ];
    buildInputs = [ pkgs.openssl ];
    cargoArtifacts = craneLib.buildDepsOnly {
      src = src;
      strictDeps = true;
      nativeBuildInputs = [ pkgs.pkg-config pkgs.perl ];
      buildInputs = [ pkgs.openssl ];
    };
  };
  plugin = pkgs.vimUtils.buildVimPlugin {
    pname = "fff.nvim";
    version = "unstable-2025-08-08";
    src = src;
    doCheck = false;
    postInstall = ''
      mkdir -p $out/lua
      cp ${backend}/lib/libfff_nvim.so $out/lua/fff_nvim.so
    '';
  };
in {
  vimPlugins = prev.vimPlugins // { fff-nvim = plugin; };
}

