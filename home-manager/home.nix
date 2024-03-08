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
  nixpkgs = {
    config.permittedInsecurePackages = with pkgs; ["nix-2.16.2"];
    overlays = builtins.attrValues outputs.overlays;
  };
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
