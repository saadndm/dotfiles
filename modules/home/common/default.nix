{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nvim.homeModules.default
    ./packages.nix
    ./agenix.nix
    ./shell.nix
    ./git.nix
    ./catppuccin.nix
    ./yazi.nix
  ];

  nvim.enable = true;

  home = {
    username = "bridgesense";
    homeDirectory = "/home/bridgesense";
    stateVersion = "25.05";
    sessionVariables = {
      EDITOR = "nvim";
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    };
    packages = with pkgs; [
      home-manager
    ];
  };
}
