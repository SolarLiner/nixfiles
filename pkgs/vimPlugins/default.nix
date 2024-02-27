{
  pkgs,
  lib,
  ...
}:
with pkgs;
with lib; {
  nvim-web-tools = callPackage ./nvim-web-tools.nix {};
  utilsnips = callPackage ./utilsnips.nix {};
  vscode-nvim = callPackage ./vscode-nvim.nix {};
}
