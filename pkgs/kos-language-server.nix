{
  buildNpmPackage,
  fetchFromGitHub,
  lib,
  ...
} @ pkgs: let
  revision = "aff3a4743f5492a878cbfb5d2938e2e90f83cb45";
in
  buildNpmPackage rec {
    pname = "kos-language-server";
    version = revision;

    src = fetchFromGitHub {
      owner = "jonnyboyC";
      repo = pname;
      rev = revision;
      sha256 = "sha256-l02VJo9Tgmo4kItC4WQtwIzGA1LupP3NmGhTXhw3Dqs=";
    };

    sourceRoot = "${src.name}/server";

    npmDepsHash = "sha256-ZxL/wfog1ThRjugk7k0TJXmsd47oJi45IqgxP3ZU784=";
    npmBuildScript = "bundle";

    meta.mainProgram = "kls";
  }
