{...}: {
  imports = [
    ./minimal.nix
    ../modules/flatpak.nix
    ../modules/intellij.nix
    ../modules/lapce.nix
    ../modules/mpd.nix
    ../modules/node.nix
    ../modules/plasma.nix
    ../modules/python.nix
    ../modules/rust.nix
    ../modules/terminal.nix
    ../modules/topgrade.nix
    ../modules/vscode.nix
    ../modules/zed.nix
  ];
}
