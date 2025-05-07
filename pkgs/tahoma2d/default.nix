{
  boost,
  cmake,
  fetchFromGitHub,
  libdeflate,
  libglut,
  freetype,
  glew,
  libjpeg,
  libmypaint,
  libpng,
  libusb1,
  lz4,
  xz,
  lzo,
  openblas,
  opencv,
  pkg-config,
  libsForQt5,
  lib,
  stdenv,
  superlu,
  libtiff,
  zlib,
}: let
  libtiff-ver = "4.2.0"; # The version in thirdparty/tiff-*
  tahoma2d-ver = "1.5.2";

  src = fetchFromGitHub {
    owner = "tahoma2d";
    repo = "tahoma2d";
    rev = "refs/tags/v${tahoma2d-ver}";
    hash = "sha256-ILjUvQgBK7sRLiHmInNiQGeuOmjpuzsZEZSz153WMS8=";
  };

  # tahoma2d-opencv = opencv.override {
  #   inherit libtiff;
  # };
  #
  tahoma2d-libtiff = stdenv.mkDerivation {
    pname = "libtiff";
    version = "${libtiff-ver}-tahoma2d";

    inherit src;
    outputs = [
      "bin"
      "dev"
      "out"
      "man"
      "doc"
    ];

    nativeBuildInputs = [pkg-config];
    propagatedBuildInputs = [
      zlib
      libjpeg
      xz
    ];

    postUnpack = ''
      sourceRoot="$sourceRoot/thirdparty/tiff-${libtiff-ver}"
    '';

    # tahoma2d uses internal libtiff headers
    postInstall = ''
      cp libtiff/{tif_config,tif_dir,tiffiop}.h $dev/include
    '';
  };
in
  stdenv.mkDerivation {
    inherit src;

    pname = "tahoma2d";
    version = tahoma2d-ver;

    nativeBuildInputs = [
      cmake
      pkg-config
      libsForQt5.qt5.wrapQtAppsHook
    ];

    buildInputs = [
      boost
      libdeflate
      libglut
      freetype
      glew
      libjpeg
      libmypaint
      libpng
      tahoma2d-libtiff
      libusb1
      lz4
      xz
      lzo
      openblas
      # tahoma2d-opencv
      opencv
      libsForQt5.qt5.qtbase
      libsForQt5.qt5.qtmultimedia
      libsForQt5.qt5.qtscript
      libsForQt5.qt5.qtserialport
      superlu
    ];

    postUnpack = "sourceRoot=$sourceRoot/toonz";

    cmakeDir = "../sources";
    cmakeFlags = [
      "-DCMAKE_SKIP_BUILD_RPATH=ON"
      "-DTIFF_INCLUDE_DIR=${tahoma2d-libtiff.dev}/include"
      "-DTIFF_LIBRARY=${tahoma2d-libtiff.out}/lib/libtiff.so"
      (lib.cmakeBool "CMAKE_SKIP_BUILD_RPATH" true)
    ];

    postPatch = ''
      substituteInPlace /build/source/toonz/sources/include/tthreadmessage.h \
        --replace-fail "#include <QMutex>" "#include <QRecursiveMutex>" \
        --replace-fail "QMutex::Recursive" "QRecursiveMutex::QRecursiveMutex"
    '';

    postInstall = ''
      sed -i '/cp -r .*stuff/a\    chmod -R u+w $HOME/.config/Tahoma2D/stuff' $out/bin/tahoma2d
    '';

    meta = {
      description = "Full-featured 2D animation creation software";
      homepage = "";
      license = lib.licenses.bsd3;
      maintainers = with lib.maintainers; [chkno];
    };
  }
