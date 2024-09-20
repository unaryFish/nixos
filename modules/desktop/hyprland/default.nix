{ pkgs, inputs, lib, config, ... }: {

    options = {
      hyprland.enable = 
        lib.mkEnableOption "Enable hyprland module";
    };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      
      xwayland = {
        enable = true;
      };

      settings = {
        "$mainMod" = "SUPER";
        # monitor = [];

        xwayland = {
          force_zero_scaling = true;
        };

        input = {
          kb_layout = "za";

          follow_mouse = 1;
          repeat_delay = 140;
          repeat_rate = 30;
          numlock_by_default = 1;
          accel_profile = "flat";
          sensitivity = 0;
          force_no_accel = 1;
          touchpad = {
            natural_scroll = 1;
          };
        };
        
        cursor = {
          enable_waycursor = true;
        };

        general = {
          gaps_in = 2;
          gaps_out = 1;
          border_size = 0;
          layout = "dwindle";
        };

        decoration = {
          rounding = 3;
          shadow_ignore_window = true;
          drop_shadow = false;
          shadow_range = 15;
          shadow_render_power = 2;

          blur = {
            enabled = true;
            size = 2;
            passes = 2;
            new_optimizations = true;
            ignore_opacity = false;
            noise = 1.17e-2;
            contrast = 1.3;
            brightness = 1;
            xray = true;
          };
        };

        animations = {
          enabled = false;

          bezier = [ "1, 0.23, 1, 0.32, 1" ];

          animation = [
            "windows, 1, 5, 1"
            "windowsIn, 1, 5, 1, slide"
            "windowsOut, 1, 5, 1, slide"
            "border, 1, 5, default"
            "borderangle, 1, 5, default"
            "fade, 1, 5, default"
            "workspaces, 1, 5, 1, slidefade 30%"
          ];
        };
          
        misc = {
          vfr = true;
          vrr = false;
          disable_hyprland_logo = true;
        };

        dwindle = {
          pseudotile = true;
          force_split = 0;
          preserve_split = true;
          default_split_ratio = 1.0;
          no_gaps_when_only = false;
          special_scale_factor = 0.8;
          split_width_multiplier = 1.0;
          use_active_for_splits = true;
        };

        master = {
          mfact = 0.5;
          orientation = "right";
          special_scale_factor = 0.8;
          new_status = "slave";
          no_gaps_when_only = false;
        };

        gestures = {
          workspace_swipe = false;
        };

        debug = {
          damage_tracking = 2;
        };

        bind = [
          "SUPER,Q,killactive,"
          "SUPER,M,exit,"
          "SUPER,S,togglefloating,"
          "SUPER,g,togglegroup"

          # Movement between windows 
          "SUPER,h,movefocus,l"
          "SUPER,l,movefocus,r"
          "SUPER,k,movefocus,u"
          "SUPER,j,movefocus,d"

          # Movement between workspaces
          "SUPER,1,workspace,1"
          "SUPER,2,workspace,2"
          "SUPER,3,workspace,3"
          "SUPER,4,workspace,4"
          "SUPER,5,workspace,5"
          "SUPER,6,workspace,6"
          "SUPER,7,workspace,7"
          "SUPER,8,workspace,8"
          "SUPER,9,workspace,9"
          "SUPER,0,workspace,10"

          # Move windows in a workspace
          "SUPER SHIFT, H, movewindow, l"
          "SUPER SHIFT, L, movewindow, r"
          "SUPER SHIFT, K, movewindow, u"
          "SUPER SHIFT, J, movewindow, d"

          # Move window to a different workspace
          "SUPER $mainMod SHIFT, 1, movetoworkspacesilent, 1"
          "SUPER $mainMod SHIFT, 2, movetoworkspacesilent, 2"
          "SUPER $mainMod SHIFT, 3, movetoworkspacesilent, 3"
          "SUPER $mainMod SHIFT, 4, movetoworkspacesilent, 4"
          "SUPER $mainMod SHIFT, 5, movetoworkspacesilent, 5"
          "SUPER $mainMod SHIFT, 6, movetoworkspacesilent, 6"
          "SUPER $mainMod SHIFT, 7, movetoworkspacesilent, 7"
          "SUPER $mainMod SHIFT, 8, movetoworkspacesilent, 8"

          # Launch apps
          "SUPER,RETURN,exec,tmux"
          "SUPER,d,exec,rofi"

          # Floating windows
          "float,class:^(pavucontrol)$"
          "float,class:^(file_progress)$"
          "float,class:^(confirm)$"
          "float,class:^(dialog)$"
          "float,class:^(download)$"
          "float,class:^(notification)$"
          "float,class:^(error)$"
          "float,class:^(confirmreset)$"
          "float,title:^(Open File)$"
          "float,title:^(branchdialog)$"
          "float,title:^(Confirm to replace files)$"
          "float,title:^(File Operation Progress)$"
          "float,title:^(mpv)$"
        ];
      };
    };
  };
}
