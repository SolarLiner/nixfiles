{...}: {
  imports = [
    ./minimal.nix
    ../modules/intellij.nix
    ../modules/python.nix
    ../modules/rust.nix
    ../modules/terminal.nix
    ../modules/topgrade.nix
    ../modules/node.nix
    ../modules/vscode.nix
    ../modules/zed.nix
  ];
}
