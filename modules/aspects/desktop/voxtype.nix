{inputs, ...}: {
  flake-file.inputs.voxtype = {
    url = "github:peteonrails/voxtype";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.voxtype.homeManager = {pkgs, ...}: let
    vtPkgs = inputs.voxtype.packages.${pkgs.stdenv.hostPlatform.system};
    # nixpkgs' Cargo hook requires system SQLite, missing from the own flake.
    vulkanUnwrapped = vtPkgs.voxtype-vulkan-unwrapped.overrideAttrs (old: {
      buildInputs = (old.buildInputs or []) ++ [pkgs.sqlite];
    });
    vulkan = vtPkgs.vulkan.overrideAttrs {
      paths = [vulkanUnwrapped];
    };
    osdGtk4 = vtPkgs.osd-gtk4.overrideAttrs (old: {
      buildInputs = (old.buildInputs or []) ++ [pkgs.sqlite];
    });
  in {
    imports = [inputs.voxtype.homeManagerModules.default];

    programs.voxtype = {
      enable = true;
      package = vulkan;
      model.name = "base.en";
      service.enable = true;
      settings = {
        hotkey.enabled = false;
        whisper.language = "en";
        osd = {
          position = "top-center";
          top_margin = 0.06;
        };
      };
    };

    home.packages = [osdGtk4];

    programs.niri.settings.binds = {
      "Mod+D" = {
        action.spawn = ["voxtype" "record" "toggle"];
        repeat = false;
      };
      "Mod+Ctrl+D" = {
        action.spawn = ["voxtype" "record" "start"];
        repeat = false;
        hotkey-overlay.hidden = true;
      };
      "Mod+Ctrl+Shift+D" = {
        action.spawn = ["voxtype" "record" "stop"];
        repeat = false;
        hotkey-overlay.hidden = true;
      };
    };
  };
}
