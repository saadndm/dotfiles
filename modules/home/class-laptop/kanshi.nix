{
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";

    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            scale = 2.0;
            mode = "2880x1800@120Hz";
            status = "enable";
          }
        ];
      }

      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            scale = 2.0;
            mode = "2880x1800@120Hz";
            status = "disable";
          }
          {
            criteria = "AOC Q27G3XMN 1APQCJA000040";
            scale = 1.6;
            mode = "2560x1440@180Hz";
            status = "enable";
          }
        ];
      }
    ];
  };
}
