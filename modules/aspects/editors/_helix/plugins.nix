{pkgs, ...}: {
  # Provided by the helix-plugins overlay in nixpkgs-settings and app.nix.
  programs.helix.plugins = with pkgs.helixPlugins; [
    (buildHelixPlugin {
      pname = "dugtrio.hx";
      version = "0.1.0";

      src = pkgs.fetchFromGitHub {
        owner = "howird";
        repo = "dugtrio.hx";
        rev = "3e851d505d02b84bcd250d480247d320ddda94f2";
        hash = "sha256-n1Tga02qz8/JSlT1v6InwzJhyNFcToOPxDNPd21QIBk=";
      };

      passthru = {
        cogName = "dugtrio";
        pluginDependencies = [glyph-hx];
      };
    })
    (buildHelixPluginWithNative {
      pname = "math-hx";
      version = "0.1.0";

      src = pkgs.fetchFromGitHub {
        owner = "howird";
        repo = "math.hx";
        rev = "c37f0d2efc5c090ed95cb275620c0adbf7af74e4";
        hash = "sha256-SIRJcD3Y4GfMOiRioiGeFa0mmwrT0vqsRAL80ZauyeA=";
      };

      cargoHash = "sha256-x6wVcoKHL1L9qWosqGFdK7u/YMjUz/qyy4f7cljqGh0=";

      meta = {
        description = "Typst previews of LaTeX math in markdown";
        license = pkgs.lib.licenses.mit;
      };
    })
    (helix-file-watcher.overrideAttrs {
      postPatch = ''
        substituteInPlace file-watcher.scm --replace-fail \
          '(watch-file! watch-handle x)) paths)' \
          '(watch-file! watch-handle x)) (hashset->list (list->hashset (map parent-name paths))))'
      '';
    })
  ];

  xdg.configFile."helix/init.scm".source = ./init.scm;
}
