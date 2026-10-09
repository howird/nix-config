{
  config,
  pkgs,
  lib,
  ...
}: let
  desktopEntry = import ./desktop-entry.nix pkgs;
  entries = with pkgs; {
    document = desktopEntry papers "org.gnome.Papers.desktop";
    image = desktopEntry loupe "org.gnome.Loupe.desktop";
    video = desktopEntry showtime "org.gnome.Showtime.desktop";
    text = desktopEntry gnome-text-editor "org.gnome.TextEditor.desktop";
    code = desktopEntry zed-editor "dev.zed.Zed.desktop";
    directory = desktopEntry yazi "yazi.desktop";
    markdown = desktopEntry typora "typora.desktop";
    magnet = desktopEntry qbittorrent "org.qbittorrent.qBittorrent.desktop";
  };
in {
  imports = [
    ./url-router.nix
  ];

  options = with lib; {
    myApps = {
      document = mkOption {
        type = types.str;
        default = entries.document.name;
      };
      image = mkOption {
        type = types.str;
        default = entries.image.name;
      };
      video = mkOption {
        type = types.str;
        default = entries.video.name;
      };
      text = mkOption {
        type = types.str;
        default = entries.text.name;
      };
      code = mkOption {
        type = types.str;
        default = entries.code.name;
      };
    };
  };

  config = {
    home.packages = with pkgs; [
      file
    ];

    home.checks = map (e: e.check) (lib.attrValues entries);

    xdg.mimeApps = {
      enable = true;

      defaultApplications = with config.myApps; {
        "inode/directory" = entries.directory.name;

        "application/pdf" = document;
        "text/plain" = text;
        "text/csv" = text;

        "application/x-latex" = code;
        "text/x-tex" = code;

        "video/mp4" = video;
        "video/webm" = video;
        "video/x-matroska" = video;

        "image/gif" = image;
        "image/jpeg" = image;
        "image/png" = image;
        "image/svg+xml" = image;

        "text/markdown" = entries.markdown.name;
        "x-scheme-handler/magnet" = entries.magnet.name;
      };
    };
  };
}
