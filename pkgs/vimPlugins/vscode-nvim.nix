{
  pkgs,
  lib,
  ...
}:
with lib;
with pkgs;
with vimUtils;
  buildVimPlugin {
    pname = "vscode.nvim";
    version = "2024-02-01";
    src = pkgs.fetchFromGitHub {
      owner = "Mofiqul";
      repo = "vscode.nvim";
      rev = "3f3bd3efbd74bf1d9b78dce0c9672c917f28f9f5";
      sha256 = "sha256-fAlAcLShnQ0r1E/MiaJuB4ZL8b/nYDjREOqDQXAPHnU=";
    };
    meta.homepage = "https://github.com/Mofiqul/vscode.nvim/";
  }
