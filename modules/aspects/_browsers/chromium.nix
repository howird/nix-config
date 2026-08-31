{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.chromium = {
    enable = config.myBrowser.chromium;
    package = pkgs.ungoogled-chromium.override {enableWideVine = true;};
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
    extensions = let
      createChromiumExtensionFor = browserVersion: {
        id,
        sha256,
        version,
      }: {
        inherit id;
        crxPath = builtins.fetchurl {
          url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
          name = "${id}.crx";
          inherit sha256;
        };
        inherit version;
      };
      createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
    in [
      (createChromiumExtension {
        # bitwarden
        id = "nngceckbapebfimnlniiiahkandclblb";
        sha256 = "sha256:1fpylw7d1scsjfn9zm6impqajkp4dwmbmgbwv0mynvwxrjqvhc1a";
        version = "2026.4.0";
      })
      (createChromiumExtension {
        # google docs offline
        id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi";
        sha256 = "sha256:0m9f64wp4zgbr2gsqc8dxm53a7956mfgndibh3swsv3h7hgn4mij";
        version = "1.104.1";
      })
      (createChromiumExtension {
        # chrome dark scheme toggle
        id = "idnbggfpadjhjicgjmhlpeilafaplnhd";
        sha256 = "sha256:0b6842ppgxkx016yndmmnik1nwri588l8sy8kj1ac5wfv8l2nhps";
        version = "1.1.2";
      })
    ];
  };
}
