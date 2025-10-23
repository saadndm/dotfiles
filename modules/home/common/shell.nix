{
  pkgs,
  lib,
  ...
}:
{
  programs.fish = {
    enable = true;
    binds = {
      "ctrl-y" = {
        command = "forward-char";
        mode = "insert";
      };
      "ctrl-p" = {
        command = "up-or-search";
        mode = "insert";
      };
      "ctrl-n" = {
        command = "down-or-search";
        mode = "insert";
      };
    };
    shellAbbrs = {
      n = "nvim";
      lg = "lazygit";
      ld = "DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock sudo lazydocker";
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles#(hostname)";
      hrs = "home-manager switch --flake ~/dotfiles";
      y = "yazi";
      ts = "tailscale";
      fzf = "fzf --preview \"bat --color=always --style=numbers --line-range=:500 {}\"";
      lsn = "ls";
    };
    shellAliases = {
      cat = "bat --paging=never";
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
