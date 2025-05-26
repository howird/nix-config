{config, ...}: {
  xdg.configFile."swayosd/style.css".text = let
    colors = config.lib.stylix.colors.withHashtag;
    text = colors.base05;
    base = colors.base00;
    surface2 = colors.base04;
    green = colors.base0B;
  in ''
    window {
        padding: 0px 10px;
        border-radius: 30px;
        border: 10px;
        background: alpha(${base}, 0.99);
    }

    #container {
        margin: 15px;
    }

    image, label {
        color: ${text};
    }

    progressbar:disabled,
    image:disabled {
        opacity: 0.95;
    }

    progressbar {
        min-height: 6px;
        border-radius: 999px;
        background: transparent;
        border: none;
    }
    trough {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background: alpha(${surface2}, 0.1);
    }
    progress {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background: ${green};
    }
  '';
}
