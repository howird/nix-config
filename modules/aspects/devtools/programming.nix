{
  den.aspects.programming.homeManager = {
    config,
    lib,
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      # better disk usage tuis
      dust
      dua

      ast-grep # abstract code grep
      scooter # search and replace tui
      glow # markdown reader tui
      fastfetch
      yt-dlp
    ];

    programs.nh = {
      enable = true;
      flake = config.myShell.flakePath;
    };

    programs.ripgrep.enable = true;
    programs.uv.enable = true;
    programs.fd.enable = true;
    programs.bat.enable = true;
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = config.programs.zsh.enable;
      enableNushellIntegration = config.programs.nushell.enable;
    };
    programs.eza = {
      enable = true;
      enableZshIntegration = config.programs.zsh.enable;
    };
    programs.fzf = {
      enable = true;
      enableZshIntegration = config.programs.zsh.enable;
      # Sourced below instead, with the completer patched.
      enableNushellIntegration = false;
    };
    # fzf's completer still takes the positional `spans` input, which nushell
    # 0.116 deprecates with a warning on every tab completion. `--replace-fail`
    # flags when upstream migrates and this can go back to the integration above.
    programs.nushell.extraConfig = lib.mkAfter ''
      source ${pkgs.runCommand "nushell-fzf-integration.nu" {} ''
        ${lib.getExe config.programs.fzf.package} --nushell > $out
        substituteInPlace $out --replace-fail \
          'let fzf_wrapper_completer = {|spans|' \
          'let fzf_wrapper_completer = {|place| let spans = $place.command'
      ''}
    '';
    programs.zoxide = {
      enable = true;
      enableZshIntegration = config.programs.zsh.enable;
      enableNushellIntegration = config.programs.nushell.enable;
    };
  };
}
