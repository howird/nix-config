# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
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
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # TODO(howird): update obsidian version to not use this electron version
      permittedInsecurePackages = [ "electron-25.9.0" ];
    };
  };

  home = {
    username = "howird";
    homeDirectory = "/home/howird";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    packages = with pkgs; [
      obsidian
      stremio
    ];
  };

  # Add stuff for your user as you see fit:

  # Enable home-manager and git
  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      lfs.enable = true;
      userName  = "Howard Nguyen-Huu";
      userEmail = "howardnguyenhuu@gmail.com";
      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      shellAliases = {
        ll = "ls -l";
        vim = "nvim";
        nix-rs = "sudo nixos-rebuild switch --flake /home/howird/.config/nix";
        nix-hm-rs = "home-manager switch --flake /home/howird/.config/nix";
      };
      history = {
        size = 10000;
        path = "$HOME/.config/zsh/history";
      };
      oh-my-zsh = {
        enable = true;
        # plugins = [ "powerlevel10k" ];
        theme = "robbyrussell";
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    vscode = {
      enable = true;
      # package = pkgs.vscode.fhsWithPackages (ps: with ps; [ rustup zlib openssl.dev pkg-config ]);
      extensions = with pkgs.vscode-extensions; [
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
      ];
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
