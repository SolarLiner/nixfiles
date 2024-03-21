{tracy, fetchFromGitHub,...}: tracy.overrideAttrs (oldAttrs: rec {
  version = "0.9.1";
  src = fetchFromGitHub {
    owner = "wolfpld";
    repo = "tracy";
    rev = "v${version}";
    sha256 = "sha256-K1lQNRS8+ju9HyKNVXtHqslrPWcPgazzTitvwkIO3P4=";
  };
})
