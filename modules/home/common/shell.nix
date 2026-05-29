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
      nrs = "sudo -v && nh os switch";
      hrs = "nh home switch";
      ts = "tailscale";
      fzf = "fzf --preview \"bat --color=always --style=numbers --line-range=:500 {}\"";
      lsn = "command ls";
      man = "batman";
      cat = "bat --paging=never";
      lst = "eza --tree --level=3";
      o = "opencode";
    };
    shellAliases = {
      kopia = "sudo kopia --config-file=/var/lib/kopia/$hostname-backup/repository.config";
    };
    plugins = with pkgs.fishPlugins; [
      {
        name = "tide";
        inherit (tide) src;
      }
    ];
    interactiveShellInit = ''
      set fish_greeting ""

      bind -M visual ' 'y fish_clipboard_copy
      set fish_cursor_external line
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
