{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../users/nixos.nix
  ];
  system.stateVersion = "25.11";

  environment.systemPackages = with pkgs; [gcc clang gnumake ninja cmake meson pkg-config];
  virtualisation.docker.enable = true;
  wsl.enable = true;
}
