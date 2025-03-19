{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = let
      code = "dev.zed.Zed.desktop";
      text = "org.gnome.TextEditor.desktop";
      video = "vlc.desktop";
      image = "org.gnome.Loupe.desktop";
      document = "org.gnome.Evince.desktop";
      browser = "vivaldi-stable.desktop";
    in {
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
}
