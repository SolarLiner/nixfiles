{...}: {
  imports = [
    ./minimal.nix
    ../modules/python.nix
    ../modules/rust.nix
    ../modules/terminal.nix
    ../modules/vscode.nix
    ../modules/intellij.nix
    ../modules/firefox.nix
  ];
}
