{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./nvf.nix
  ];

  programs.nvf = {
    enable = config.myEditor.nvim;
    enableManpages = true;
  };
}
