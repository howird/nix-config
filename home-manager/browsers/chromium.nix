{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.chromium = {
    enable = config.myBrowser.chromium;
    package = pkgs.ungoogled-chromium;
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
        sha256 = "sha256:0vlgm61wgp2gr2b7ys2pmasj7s202xjvv6h13inj41gbll1rpywn";
        version = "2025.5.1";
      })
      (createChromiumExtension {
        # google docs offline
        id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi";
        sha256 = "sha256:1zyzqqclnzqgrr9wjiz4b2rckxa8z7fysyiwrfx5m0j2f7xi24zv";
        version = "1.92.1";
      })
    ];
  };
}
