{
  pkgs,
  lib,
  ...
}: {
  programs.pi.coding-agent.settings = {
    npmCommand = [(lib.getExe pkgs.bun)];
  };
}
