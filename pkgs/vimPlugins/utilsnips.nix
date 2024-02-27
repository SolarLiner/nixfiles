{
  pkgs,
  lib,
  ...
}:
with pkgs;
with vimUtils;
with lib;
  buildVimPlugin {
    pname = "utilsnips";
    src = pkgs.fetchFromGitHub {
      repo = "utilsnips";
      owner = "SirVer";
      rev = "b393ba65386d47664421e1f8b246a87a6e8b218c";
      sha256 = null;
    };
  }
