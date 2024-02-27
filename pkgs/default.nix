# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs:
with pkgs; {
  clangd = callPackage ./clangd.nix {};
  extraVimPlugins = callPackage ./vimPlugins {};
  wgsl-analyzer = callPackage ./wgsl-analyzer.nix {};
}
