{
  stdenvNoCC,
  fetchzip,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "iosevka-nerd-fonts";
  version = "3.2.1";
  src = fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/Iosevka.zip";
    sha256 = "sha256-a3GuAsPJW7hfDLZsU8UV98dL5U3C6GhxeZxlxvFmT/s=";
    stripRoot = false;
  };
  phases = ["installPhase"];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/truetype
    cp -v $src/*.ttf $out/share/fonts/truetype
    runHook postInstall
  '';
}
