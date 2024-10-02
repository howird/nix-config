{
  stdenv,
  lib,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "Chicago95";
  version = "09.30.24";

  src = fetchFromGitHub {
    owner = "grassmunk";
    repo = pname;
    rev = "bdf5cf36a16102aaac297f3de887c601c2b1146f";
    sha256 = "sha256-1TW3bUZOUB6AGZ4zC274YpDg6t/UfZFEuDCHqtbw2oU=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/{themes,icons}
    cp -r Theme/Chicago95 $out/share/themes
    cp -r Icons/* $out/share/icons

    runHook postInstall
  '';

  meta = with lib; {
    description = "A rendition of everyone's favorite 1995 Microsoft operating system for Linux.";
    homepage = "https://github.com/grassmunk/Chicago95";
    # license = licenses.gpl3;
    platforms = platforms.all;
  };
}
