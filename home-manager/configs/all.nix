{ ... }: {
  imports = [
    ./minimal.nix
    ../modules/terminal.nix
    ../modules/vscode.nix
    ../modules/node.nix
    ../modules/ocaml.nix
    ../modules/firefox.nix
  ];
}
