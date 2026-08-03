_: {
  boot.kernelParams = [ "vt.global_cursor_default=0" ];

  services.getty = {
    autologinUser = "bridgesense";
    extraArgs = [
      "--skip-login"
      "--noissue"
    ];
  };

  programs.fish.loginShellInit = ''
    if test (tty) = /dev/tty1
      exec start-hyprland >/dev/null
    end
  '';
}
