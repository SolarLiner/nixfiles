{...}: {
  imports = [
    ../modules/debugging.nix
    ../modules/intellij.nix
    ../modules/node.nix
    ../modules/python.nix
    ../modules/rust.nix
    ../modules/terminal.nix
    ../modules/topgrade.nix
    ../modules/vscode.nix
    ../modules/zed.nix
    ./minimal.nix
  ];
}
