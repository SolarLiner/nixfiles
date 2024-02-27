{
  pkgs,
  lib,
  ...
}:
with lib;
with pkgs;
with stdenvNoCC;
  mkDerivation rec {
    pname = "wgsl-analyzer";
    version = "0.8.1";
    src = builtins.fetchurl {
      url = "https://github.com/wgsl-analyzer/wgsl-analyzer/releases/download/v${version}/wgsl_analyzer-linux-x64";
      sha256 = "sha256:1rji9s8m2ivqn6qwd2rv8x32rvbpwxym2wwh1y3z5xrhfmy3s5sr";
    };
    buildInputs = [libgcc];
    nativeBuildInputs = lib.optionals (!stdenv.isDarwin) [autoPatchelfHook];
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/bin
      pwd
      ls -a $src
      install -m755 -D $src $out/bin/${pname}
    '';
  }
