{ pkgs, lib, config, ... }: 
  let 
    cfg = config.drivers;
  in {

    options = {
      drivers.enable = 
        lib.mkEnableOption "Enable Nvidia drivers";
    };

    config = lib.mkIf cfg.enable {

      # Previously hardware.openGL
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      hardware.nvidia = {
        # Fixes screen tearing
        modesetting.enable = true;

        # Enable if you have graphical corruption issues
        # Can cause sleep/suspend to fail (experimental)
        powerManagement.enable = false;
        # Turns off GPU while not in use (experimental)
        powerManagement.finegrained = false;

        # Make use of open drivers
        open = false;
        # Enables settings menu
        nvidiaSettings = true;

        # Driver version
        package = config.boot.kernelPackages.nvidiaPackages.production;

        prime = {
          # Reduces screen tearing
          # Higher power consumption
          sync.enable = true;
          amdgpuBusId = "PCI:06:00:0";
          nvidiaBusId = "PCI:01:00:0";
        };
      };
    };
  }
