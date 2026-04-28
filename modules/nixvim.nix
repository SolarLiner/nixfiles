{
  lib,
  pkgs,
  ...
}: let
  loadNixFiles = folder:
    lib.lists.filter
    (lib.strings.hasSuffix ".nix")
    (lib.filesystem.listFilesRecursive folder);
in {imports = loadNixFiles ./nixvim;}
