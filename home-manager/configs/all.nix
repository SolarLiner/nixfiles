{...}: {
  imports = [
    ./minimal.nix
    ../modules/intellij.nix
    ../modules/terminal.nix
    ../modules/vscode.nix
    ../modules/node.nix
    ../modules/python.nix
    ../modules/rust.nix
    ../modules/ocaml.nix
    ../modules/firefox.nix
  ];
}
