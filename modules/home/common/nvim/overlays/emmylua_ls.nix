self: super:

let
  src = super.fetchFromGitHub {
    owner = "EmmyLuaLs";
    repo = "emmylua-analyzer-rust";
    rev = "689118dbcdd780fac8f022c45fdb6cd5301bc7ab";
    sha256 = "sha256-aFGVp7xw4buU0d9VJdvokz3ovJZDd17HwsBqkodDOX8=";
  };
in
{
  emmylua_ls = super.rustPlatform.buildRustPackage {
    pname = "emmylua_ls";
    version = "0.10.0";

    src = src;

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
    };

    strip = true;

    meta = with super.lib; {
      description = "Rust‑based EmmyLua language server";
      homepage = "https://github.com/EmmyLuaLs/emmylua-analyzer-rust";
      license = licenses.mit;
      maintainers = [ ];
    };
  };
}
