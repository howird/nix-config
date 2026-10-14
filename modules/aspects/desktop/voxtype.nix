{inputs, ...}: {
  flake-file.inputs.voxtype = {
    url = "github:peteonrails/voxtype";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.voxtype.homeManager = {pkgs, ...}: {
    imports = [inputs.voxtype.homeManagerModules.default];

    programs.voxtype = {
      enable = true;
      package = inputs.voxtype.packages.${pkgs.stdenv.hostPlatform.system}.vulkan;
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

    home.packages = [inputs.voxtype.packages.${pkgs.stdenv.hostPlatform.system}.osd-gtk4];

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
