{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) attrNames;
  inherit (lib.options) mkOption;
  inherit (lib.types) enum str;

  cfg = config.programs.zellij.tab-bar;
  defaultTabBar = "zellij";
  tabBars = {
    zellij = ''location="zellij:tab-bar"'';
    zjstatus = ''location="file:${pkgs.zjstatus}/bin/zjstatus.wasm"'';
  };
in {
  config.programs.zellij.tab-bar = {
    text =
      tabBars.${cfg.name}
      + (
        if cfg.settings == ""
        then ""
        else " ${cfg.settings}"
      );
    settings = (import ./zjstatus-theme.nix) {
      colors = config.lib.stylix.colors;
    };
  };

  options.programs.zellij.tab-bar = {
    name = mkOption {
      description = "";
      type = enum (attrNames tabBars);
      default = defaultTabBar;
    };
    settings = mkOption {
      type = str;
      default = "";
    };
    text = mkOption {
      type = str;
      default = "";
    };
  };
}
