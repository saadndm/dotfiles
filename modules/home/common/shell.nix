{
  pkgs,
  lib,
  ...
}:
{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      n = "nvim";
      lg = "lazygit";
      ld = "DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock sudo lazydocker";
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles#(hostname)";
      hrs = "home-manager switch --flake ~/dotfiles";
      cat = "bat";
      y = "yazi";
      ts = "tailscale";
    };
    shellAliases = {
      ls = "eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions -G";
      lsa = "eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions -a -G";
      lst = "eza --color=always --tree --icons=always";
    };
    plugins = with pkgs.fishPlugins; [
      {
        name = "tide";
        inherit (tide) src;
      }
    ];
    interactiveShellInit = ''
      set fish_greeting ""
    '';
  };

  home.activation.configure-tide = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    ${pkgs.fish}/bin/fish -i -c "tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time=No --rainbow_prompt_separators=Round --powerline_prompt_heads=Round --powerline_prompt_tails=Round --powerline_prompt_style='Two lines, character' --prompt_connection=Disconnected --powerline_right_prompt_frame=No --prompt_spacing=Sparse --icons='Many icons' --transient=No"
  '';

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [
      "--cmd cd"
    ];
  };
}
