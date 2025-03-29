{
  lib,
  config,
  ...
}: {
  options = with lib; {
    myApps = {
      browser = mkOption {
        type = types.str;
        default = "zen.desktop";
      };
      document = mkOption {
        type = types.str;
        default = "org.gnome.Evince.desktop";
      };
      image = mkOption {
        type = types.str;
        default = "org.gnome.Loupe.desktop";
      };
      video = mkOption {
        type = types.str;
        default = "vlc.desktop";
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
        "text/plain" = text;
        "application/pdf" = document;
        "text/markdown" = code;

        "video/mp4" = video;
        "video/webm" = video;
        "video/x-matroska" = video;

        "image/png" = image;
        "image/jpeg" = image;
        "image/gif" = image;
        "image/svg+xml" = image;

        "text/html" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;

        "x-scheme-handler/magnet" = "org.qbittorrent.qBittorrent.desktop";
      };
    };
  };
}
