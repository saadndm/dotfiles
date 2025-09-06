{ pkgs, ... }:

let
  seamless-login = pkgs.stdenv.mkDerivation {
    pname = "seamless-login";
    version = "1.0";

    src = pkgs.writeText "seamless-login.c" ''
      #include <stdio.h>
      #include <stdlib.h>
      #include <unistd.h>
      #include <fcntl.h>
      #include <sys/ioctl.h>
      #include <linux/kd.h>
      #include <linux/vt.h>
      #include <sys/wait.h>
      #include <string.h>

      int main(int argc, char *argv[]) {
          int vt_fd;
          int vt_num = 1; // TTY1
          char vt_path[32];

          if (argc < 2) {
              fprintf(stderr, "Usage: %s <session_command>\n", argv[0]);
              return 1;
          }

          snprintf(vt_path, sizeof(vt_path), "/dev/tty%d", vt_num);
          vt_fd = open(vt_path, O_RDWR);
          if (vt_fd < 0) {
              perror("Failed to open VT");
              return 1;
          }

          if (ioctl(vt_fd, VT_ACTIVATE, vt_num) < 0) {
              perror("VT_ACTIVATE failed");
              close(vt_fd);
              return 1;
          }

          if (ioctl(vt_fd, VT_WAITACTIVE, vt_num) < 0) {
              perror("VT_WAITACTIVE failed");
              close(vt_fd);
              return 1;
          }

          if (ioctl(vt_fd, KDSETMODE, KD_GRAPHICS) < 0) {
              perror("KDSETMODE KD_GRAPHICS failed");
              close(vt_fd);
              return 1;
          }

          const char *clear_seq = "\33[H\33[2J";
          if (write(vt_fd, clear_seq, strlen(clear_seq)) < 0) {
              perror("Failed to clear VT");
          }

          close(vt_fd);

          const char *home = getenv("HOME");
          if (home) chdir(home);

          execvp(argv[1], &argv[1]);
          perror("Failed to exec session");
          return 1;
      }
    '';

    buildInputs = [ pkgs.gcc ];
    unpackPhase = "true";

    buildPhase = ''
      gcc $src -o seamless-login
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp seamless-login $out/bin/
    '';
  };
in
{
  programs.uwsm.enable = true;

  environment.systemPackages = [ seamless-login ];

  systemd.services."seamless-login" = {
    description = "Seamless Auto-Login to Hyprland";
    after = [
      "systemd-user-sessions.service"
      "getty@tty1.service"
      "plymouth-quit.service"
      "systemd-logind.service"
    ];
    conflicts = [ "getty@tty1.service" ];
    wantedBy = [ "graphical.target" ];
    partOf = [ "graphical.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${seamless-login}/bin/seamless-login ${pkgs.uwsm}/bin/uwsm start ${pkgs.hyprland}/bin/Hyprland";
      Restart = "always";
      RestartSec = 2;
      User = "bridgesense";
      TTYPath = "/dev/tty1";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
      StandardInput = "tty";
      StandardOutput = "journal";
      StandardError = "journal+console";
      PAMName = "login";
    };
  };

  systemd.services."getty@tty1".enable = false;
}
