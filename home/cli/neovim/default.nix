{ pkgs, lib, config, ...}: {

  options = {
    neovim.enable = 
      lib.mkEnableOption "Enable neovim module";
  };

  config = {
    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

        extraConfig = ''
          set number relativenumber
	        source ~/.config/neovim/init.lua
        '';
    };
  };
}  

