{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = let
      code = "nvim.desktop";
      video = "vlc.desktop";
      image = "org.gnome.Loupe.desktop";
      document = "org.gnome.Evince.desktop";
      browser = "microsoft-edge.desktop";
    in {
      "text/markdown" = code;
      "text/plain" = code;

      "video/mp4" = video;
      "video/webm" = video;
      "video/x-matroska" = video;

      "image/png" = image;
      "image/jpeg" = image;
      "image/gif" = image;
      "image/svg+xml" = image;

      "application/pdf" = document;

      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;

      "x-scheme-handler/magnet" = "org.qbittorrent.qBittorrent.desktop";
    };
  };
}
