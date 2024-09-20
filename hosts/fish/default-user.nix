{lib, config, pkgs, ...}: {

    users.users."fish" = {
      isNormalUser = true;
      initialPassword = "";
      description = "Welcome fish";
      extraGroups = [ "wheel" "networkmanager" "audio" ];
    };
  }
