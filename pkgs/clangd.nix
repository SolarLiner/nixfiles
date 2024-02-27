{
  pkgs,
  lib,
  ...
}:
with pkgs;
with stdenv;
with lib;
  mkDerivation rec {
    pname = "clangd";
    version = "17.0.3";
    src = pkgs.fetchzip {
      url = "https://github.com/clangd/clangd/releases/download/${version}/clangd-linux-${version}.zip";
      sha256 = "sha256-dwgD0a4zYLZPnoc4Kr2UBULuta/T/DKnIUKDMkIcqaY=";
    };
    # phases = [ "installPhase" ];
    nativeBuildInputs = [autoPatchelfHook];
    installPhase = ''
      runHook preInstall
      cp -rv $src $out
      runHook postInstall
    '';
  }
