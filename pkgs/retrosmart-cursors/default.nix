{
  pkgs,
  stdenv,
  lib,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "retrosmart-x11-cursors";
  version = "3.1a";

  src = fetchFromGitHub {
    owner = "mdomlop";
    repo = pname;
    rev = "1841301f16a5e754cc11d048f5187bc4ba03902a";
    sha256 = "sha256-s6LEj2C57Vq9nugjPxcIDh4hTMP3Ts7pi9Gt05YvMl4=";
  };

  nativeBuildInputs = with pkgs; [
    xorg.xcursorgen
    imagemagick
  ];

  postPatch = ''
    substituteInPlace cursors.mk \
      --replace "convert" "magick"
    substituteInPlace install.mk \
      --replace "\$(DESTDIR)/\$(PREFIX)" "$out"
  '';

  meta = with lib; {
    description = "";
    homepage = "";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
