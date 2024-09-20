{ config, pkgs, inputs, vars, ... }: {

  imports = [
    ./cli
  ];

  home.username = "${vars.userName}";
  home.homeDirectory = "/home/${vars.userName}";

  home.stateVersion = "24.11";

  home.packages = [
    pkgs.dolphin
    pkgs.libreoffice
    pkgs.tmux
    pkgs.zsh

    inputs.zen-browser.packages.${vars.system}.specific
  ];

#  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
#  };

  home.sessionVariables = {
    EDITOR = "neovim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
