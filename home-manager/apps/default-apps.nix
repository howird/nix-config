{
  lib,
  config,
  ...
}: {
  imports = [
    ./url-router.nix
  ];

  options = with lib; {
    myApps = {
      document = mkOption {
        type = types.str;
        default = "org.gnome.Papers.desktop";
      };
      image = mkOption {
        type = types.str;
        default = "org.gnome.Loupe.desktop";
      };
      video = mkOption {
        type = types.str;
        default = "org.gnome.Showtime.desktop";
      };
      text = mkOption {
        type = types.str;
        default = "org.gnome.TextEditor.desktop";
      };
      code = mkOption {
        type = types.str;
        default = "dev.zed.Zed.desktop";
      };
    };
  };

  config = {
    xdg.mimeApps = {
      enable = true;

      defaultApplications = with config.myApps; {
        "application/pdf" = document;
        "text/plain" = text;
        "text/csv" = text;

        "application/x-latex" = code;
        "text/markdown" = code;
        "text/x-tex" = code;

        "video/mp4" = video;
        "video/webm" = video;
        "video/x-matroska" = video;

        "image/gif" = image;
        "image/jpeg" = image;
        "image/png" = image;
        "image/svg+xml" = image;

        "x-scheme-handler/magnet" = "org.qbittorrent.qBittorrent.desktop";
      };
    };
  };
}
