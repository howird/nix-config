{
  lib,
  fetchFromGitHub,
  rustPlatform,
  git,
  zoxide,
  zellij,
}:
rustPlatform.buildRustPackage rec {
  pname = "zesh";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "roberte777";
    repo = pname;
    tag = "zesh-v${version}";
    hash = "sha256-10zKOsNEcHb/bNcGC/TJLA738G0cKeMg1vt+PZpiEUI=";
  };

  postPatch = ''
    substituteInPlace zellij_rs/src/lib.rs \
      --replace '"zellij"' '"${zellij}/bin/zellij"'

    substituteInPlace zesh/src/main.rs \
      --replace '"git"' '"${git}/bin/git"'

    substituteInPlace zesh_git/src/lib.rs \
      --replace '"git"' '"${git}/bin/git"'

    substituteInPlace zox_rs/src/lib.rs \
      --replace '"zoxide"' '"${zoxide}/bin/zoxide"'
  '';

  cargoHash = "sha256-N39JD7qeLzro4+6wSP14uAjH8D7kv6sGuhLomcVw600=";

  meta = with lib; {
    description = "A zellij session manager with zoxide integration.";
    homepage = "https://github.com/roberte777/zesh";
    changelog = "https://github.com/roberte777/zesh/blob/zesh-v${version}/CHANGELOG.md";
    license = with licenses; [mit];
    mainProgram = "zesh";
  };
}
