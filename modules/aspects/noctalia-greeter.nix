{inputs, ...}: {
  flake-file.inputs.noctalia-greeter = {
    url = "github:noctalia-dev/noctalia-greeter";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.noctalia-greeter.nixos = {
    config,
    lib,
    ...
  }: {
    imports = [inputs.noctalia-greeter.nixosModules.default];

    services.displayManager.noctalia-greeter = {
      enable = true;
      passwordless-sync-users = ["howird"];
      cursorTheme.package = config.stylix.cursor.package;
      settings = {
        session.default = "Niri";
        user.default = "howird";

        appearance = {
          # The look is the shell's, pushed here by Sync (Settings ->
          # Security -> Noctalia Greeter) into sync.toml
          scheme = "Synced";
          wallpaper.fill_color = config.lib.stylix.colors.withHashtag.base00;
        };

        cursor = {
          theme = config.stylix.cursor.name;
          size = config.stylix.cursor.size;
        };

        keyboard =
          {
            layout = config.services.xserver.xkb.layout;
          }
          // lib.optionalAttrs (config.services.xserver.xkb.variant != "") {
            variant = config.services.xserver.xkb.variant;
          };
      };
    };

    security.pam.services.greetd.enableGnomeKeyring =
      config.services.gnome.gnome-keyring.enable;
  };

  den.aspects.noctalia-greeter.homeManager = {
    programs.noctalia.settings.shell.greeter_sync.auto_sync = true;
  };
}
