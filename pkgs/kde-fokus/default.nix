{
  pkgs,
  stdenv,
  lib,
  fetchFromGitLab,
}:
stdenv.mkDerivation rec {
  pname = "focus-plasmoid";
  version = "2.2.0";

  src = fetchFromGitLab {
    owner = "divinae";
    repo = pname;
    rev = "8f925c5147878f9c2454fb485b64677fe697dd90";
    sha256 = "sha256-wIvmMUNOmH/2CuUVqdsti9Pu/82ZEHpZ4NXzN/PNTD4=";
  };
  # TODO: app depends on qtmultimedia, but idk how to add without getting error
  # buildInputs = [
  #   pkgs.qtmultimedia
  # ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/plasma/plasmoids/com.dv.fokus/
    cp -r package/* $out/share/plasma/plasmoids/com.dv.fokus/

    runHook postInstall
  '';

  meta = with lib; {
    description = "A simple pomodoro KDE Plasma plasmoid.";
    homepage = "https://gitlab.com/divinae/focus-plasmoid";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
