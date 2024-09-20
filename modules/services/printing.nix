{ pkgs, lib, config, ... }: 
  let 
    cfg = config.printing;
  in {

    options = {
      printing.enable = 
        lib.mkEnableOption "Enable printing";
    };

    config = lib.mkIf cfg.enable {
      # Enable CUPS to print documents
      services.printing.enable = true;
    };
  }
