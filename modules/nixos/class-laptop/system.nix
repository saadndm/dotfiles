{ pkgs, ... }:
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
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "esc";
            };
          };
        };
      };
    };
    udisks2.enable = true;
  };
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';

  environment.systemPackages = with pkgs; [
    wl-clipboard
    socat
  ];
}
