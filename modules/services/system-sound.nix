{ pkgs, lib, config, ... }:

  let
    cfg = config.system-sound;
  in {

    options = {
      system-sound.enable = 
        lib.mkEnableOption "Enables Sound";
    };

    config = lib.mkIf cfg.enable {

      # Enable RealTimeKit (priority audio scheduling)
      security.rtkit.enable = true;

      hardware.pulseaudio.enable = false;

      services.pipewire = {
        enable = true;

        # Allow apps to interact with audio hardware
        alsa.enable = true;
        alsa.support32Bit = true;

        # Compatibility layers for PulseAudio and Jack
        pulse.enable = true;
        jack.enable = true;
      };

      # Bluetooth compatibility
      services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [
            "hsp_hs" 
            "hsp_ag" 
            "hfp_hf" 
            "hfp_ag" 
          ];
        };
      };
    };
  }
