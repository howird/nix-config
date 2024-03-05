{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = { allowUnfree = true; };
  };

  home = {
    username = "howird";
    homeDirectory = "/home/howird";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    packages = ( with pkgs; [
      stremio
    ]) ++ ( with pkgs.unstable; [
      lunarvim
      obsidian
      discord
    ]);
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName  = "Howard Nguyen-Huu";
    userEmail = "howardnguyenhuu@gmail.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };

    # extraConfig = {
    #   # Sign all commits using ssh key
    #   commit.gpgsign = true;
    #   gpg.format = "ssh";
    #   user.signingkey = "~/.ssh/id_ed25519.pub";
    # };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -l";
      vim = "lvim";
      nixwird = "sudo nixos-rebuild switch --flake /home/howird/.config/nix";
      nixwird-hm = "home-manager switch --flake /home/howird/.config/nix";
    };
    history = {
      size = 10000;
      path = "$HOME/.config/zsh/history";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./.;
        file = ".p10k.zsh";
      }
    ];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    extensions = with pkgs.unstable.vscode-extensions; [
      ms-python.python
      vscodevim.vim
      yzhang.markdown-all-in-one
      rust-lang.rust-analyzer
      mechatroner.rainbow-csv
      oderwat.indent-rainbow
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
      jnoortheen.nix-ide
      njpwerner.autodocstring
      eamodio.gitlens
      github.vscode-github-actions
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-containers
      github.copilot
      github.copilot-chat
    ];
  };

  wayland.windowManager.hyprland = {
      enable = true;
      plugins = [
        # inputs.hyprland-plugins.packages."${pkgs.system}".borders-plus-plus
      ];

      settings = {
        exec-once = let
          startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
            ${pkgs.waybar}/bin/waybar &
            ${pkgs.swww}/bin/swww init &

            sleep 1

            ${pkgs.swww}/bin/swww img ${./wallpaper.jpg} &
          '';
        in ''${startupScript}/bin/start'';

        # "plugin:borders-plus-plus" = {
        #   add_borders = 1; # 0 - 9
        #   # you can add up to 9 borders
        #   "col.border_1" = "rgb(ffffff)";
        #   "col.border_2" = "rgb(2222ff)";

        #   # -1 means "default" as in the one defined in general:border_size
        #   border_size_1 = 10;
        #   border_size_2 = -1;

        #   # makes outer edges match rounding of the parent. Turn on / off to better understand. Default = on.
        #   natural_rounding = "yes";
        # };
        # Some default env vars.

        env = [
          "XCURSOR_SIZE,24"
          "QT_QPA_PLATFORMTHEME,qt5ct" # change to qt6ct if you have that
        ];

        # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          touchpad = {
          natural_scroll = true;
          };
          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        };

        general = {
            gaps_in = 5;
            gaps_out = 20;
            border_size = 2;
            #col.active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg";
            #col.inactive_border = "rgba(595959aa)";
            layout = "dwindle";
            allow_tearing = false;
        };

        decoration = {
            rounding = 10;

            blur = {
                enabled = true;
                size = 3;
                passes = 1;
                vibrancy = 0.1696;
            };

            drop_shadow = true;
            shadow_range = 4;
            shadow_render_power = 3;
            #col.shadow = "rgba(1a1a1aee)";
        };

        animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
        };

        dwindle = {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true; # you probably want this
        };

        master = {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true;
        };

        gestures = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = false;
        };

        misc = {
          force_default_wallpaper = 0;
        };

        # windowrulev2 = "suppressevent maximize, class:.*"; # You'll probably like this.

      monitor = [
        "eDP-1,1920x1080@60.03100,0x0,1.0"
      ];

      "$terminal" = "alacritty";
      "$mainMod" = "SUPER";
      "$shftMod" = "SUPERSHIFT";
      "$browser" = "vivaldi";
      "$fileManager" = "nautilus";
      "$menu" = "rofi -show run";

        bind = [
          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mainMod, T, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod SHIFT, Q, exit,"
        "$mainMod, R, exec, $menu"
          "$mainMod, B, exec, $browser"
          "$mainMod, E, exec, $fileManager"
        "$mainMod, O, exec, obsidian"
        "$mainMod, C, exec, code"
        "$mainMod, F, fullscreen, 0"
        "$mainMod SHIFT, F, fullscreen, 1"
          "$mainMod, V, togglefloating,"
          "$mainMod, P, pseudo," # dwindle
          "$mainMod, J, togglesplit," # dwindle

          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Example special workspace (scratchpad)
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };

  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
