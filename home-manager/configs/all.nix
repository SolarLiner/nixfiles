{...}: {
  imports = [
    ./minimal.nix
    ../modules/flatpak.nix
    ../modules/intellij.nix
    ../modules/lapce.nix
    ../modules/node.nix
    ../modules/ocaml.nix
    ../modules/plasma.nix
    ../modules/python.nix
    ../modules/rust.nix
    ../modules/terminal.nix
    ../modules/vscode.nix
    ../modules/zed.nix
  ];
}
