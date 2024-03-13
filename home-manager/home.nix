{
  config,
  outputs,
  pkgs,
  lib,
  isWSL ? false,
  ...
}:
with lib.lists; let
  inherit (config.home) username;
in {
  nixpkgs.overlays = builtins.attrValues outputs.overlays;
  nixpkgs.config.permittedInsecurePackages = ["nix-2.16.2"];
  home.packages = with pkgs;
    [
      # Utilities
      # Language tooling
      #coq
      docker-compose
      # Other
      git-crypt
    ]
    ++ optionals (!isWSL) [
      # Fonts
      jetbrains-mono
      iosevka
    ]
    ++ optionals isWSL [curl wget];
  home.stateVersion = "23.11";

  fonts.fontconfig.enable = !isWSL && !pkgs.stdenv.isDarwin;

  programs.home-manager.enable = true;
}
