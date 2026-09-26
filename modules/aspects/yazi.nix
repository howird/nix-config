{inputs, ...}: {
  flake-file.inputs.clipboard-yazi = {
    url = "github:XYenon/clipboard.yazi";
    flake = false;
  };

  den.aspects.yazi.homeManager = {
    config,
    pkgs,
    lib,
    ...
  }: {
    programs.yazi = {
      enable = true;
      shellWrapperName = "y";
      # clipboard.yazi shells out to wl-copy/wl-paste on wayland (osascript on darwin).
      extraPackages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [pkgs.wl-clipboard];
      plugins = {
        clipboard = inputs.clipboard-yazi;
        git = {
          package = pkgs.yaziPlugins.git;
          setup = true;
          settings.order = 1500;
        };
        vcs-files = pkgs.yaziPlugins.vcs-files;
        jump-to-char = pkgs.yaziPlugins.jump-to-char;
      };
      settings = {
        mgr.show_hidden = true;
        # git.yazi fetches status signs for files and directories alike.
        plugin.prepend_fetchers = [
          {
            url = "*";
            run = "git";
            group = "git";
          }
          {
            url = "*/";
            run = "git";
            group = "git";
          }
        ];
      };
      keymap = {
        mgr.prepend_keymap = [
          {
            on = "!";
            for = "unix";
            # yazi shell-quotes %h itself. For the hovered file/dir:
            # $f = full path, $fname = basename, $fstem = basename sans extension.
            # (not $fpath: zsh reserves it for the function search path.)
            run = ''shell 'f=%h; fname=''${f##*/}; fstem=''${fname%.*}; export f fname fstem; "$SHELL"' --block'';
            desc = "Open $SHELL here ($f, $fname, $fstem = hovered)";
          }
          # Sync yanks to the system clipboard so other apps can paste the files.
          {
            on = "y";
            run = ["yank" "plugin clipboard -- --action=copy"];
            desc = "Yank selected files (copy)";
          }
          {
            on = "x";
            run = ["yank --cut" "plugin clipboard -- --action=copy"];
            desc = "Yank selected files (cut)";
          }
          {
            on = "<C-p>";
            run = "plugin clipboard -- --action=paste";
            desc = "Paste files from the system clipboard";
          }
          {
            on = ["g" "c"];
            run = "plugin vcs-files";
            desc = "Show Git file changes";
          }
          {
            on = "f";
            run = "plugin jump-to-char";
            desc = "Jump to char";
          }
        ];
      };
    };

    # "Show in folder" (firefox, zotero, gtk file choosers) never looks at
    # mimeapps: it calls org.freedesktop.FileManager1.ShowItems over d-bus.
    # yazi is a TUI and cannot own that name, so thunar's service file answers
    # instead. This shim owns the name -- $XDG_DATA_HOME wins over the profile
    # service dirs -- and hands the path to yazi in the default terminal.
    xdg.dataFile."dbus-1/services/org.freedesktop.FileManager1.service" = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      text = let
        shim =
          pkgs.writers.writePython3Bin "yazi-filemanager1" {
            libraries = [pkgs.python3Packages.dbus-fast];
            flakeIgnore = ["E501" "F722" "F821"];
          }
          ''
            """Answer org.freedesktop.FileManager1 by opening yazi in a terminal."""
            import asyncio
            import subprocess
            from urllib.parse import unquote, urlsplit

            from dbus_fast import BusType
            from dbus_fast.aio import MessageBus
            from dbus_fast.service import ServiceInterface, method

            TERMINAL = "${pkgs.xdg-terminal-exec}/bin/xdg-terminal-exec"
            YAZI = "${config.programs.yazi.finalPackage}/bin/yazi"


            def to_path(uri):
                parts = urlsplit(uri)
                if parts.scheme not in ("", "file"):
                    return None
                if parts.netloc not in ("", "localhost"):
                    return None
                return unquote(parts.path) or None


            def open_entries(uris):
                entries = []
                for uri in uris:
                    path = to_path(uri)
                    if path is not None and path not in entries:
                        entries.append(path)
                for path in entries:
                    subprocess.Popen([TERMINAL, YAZI, path], start_new_session=True)


            class FileManager1(ServiceInterface):
                def __init__(self):
                    super().__init__("org.freedesktop.FileManager1")

                @method()
                def ShowFolders(self, uris: "as", startup_id: "s"):
                    open_entries(uris)

                @method()
                def ShowItems(self, uris: "as", startup_id: "s"):
                    open_entries(uris)

                @method()
                def ShowItemProperties(self, uris: "as", startup_id: "s"):
                    open_entries(uris)


            async def main():
                bus = await MessageBus(bus_type=BusType.SESSION).connect()
                bus.export("/org/freedesktop/FileManager1", FileManager1())
                await bus.request_name("org.freedesktop.FileManager1")
                await bus.wait_for_disconnect()


            asyncio.run(main())
          '';
      in ''
        [D-BUS Service]
        Name=org.freedesktop.FileManager1
        Exec=${shim}/bin/yazi-filemanager1
      '';
    };
  };
}
