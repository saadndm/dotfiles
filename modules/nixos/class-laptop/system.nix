{ ... }:
{
  hardware.bluetooth.enable = true;

  services = {
    tuned = {
      enable = true;
      ppdSettings = {
        profiles = {
          performance = "throughput-performance";
          balanced = "balanced";
          power-saver = "laptop-ac-powersave";
        };

        battery = {
          performance = "throughput-performance";
          balanced = "balanced-battery";
          power-saver = "laptop-battery-powersave";
        };
      };
    };
    udisks2.enable = true;
    logind = {
      settings.Login = {
        HandlePowerKey = "suspend";
        HandlePowerKeyLongPress = "poweroff";
        HandleLidSwitch = "suspend";
        HandleLidSwitchDocked = "ignore";
        HandleLidSwitchExternalPower = "suspend";
        HoldoffTimeoutSec = 5;
      };
    };
    upower.ignoreLid = true;
  };

  environment.etc."libinput/local-overrides.quirks".text = ''
    [Glorious Model O Wireless NoDebounce]
    MatchName=Glorious Model O Wireless
    ModelBouncingKeys=1
  '';
}
