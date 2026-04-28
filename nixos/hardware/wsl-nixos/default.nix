{
  imports = [
    ../../users/nixos.nix
  ];
  wsl.enable = true;
  programs.nix-ld.enable = true;
  system.stateVersion = "25.11";
}
