{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./nvf.nix
  ];

  home.sessionVariables.EDITOR = "vim";
  programs.nvf = {
    enable = config.myEditor.nvim;
    enableManpages = true;
  };
}
