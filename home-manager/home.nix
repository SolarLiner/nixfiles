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
      nerd-fonts
      # Programs
      gimp
    ]
    ++ optionals isWSL [curl wget];
  home.stateVersion = "23.11";

  fonts.fontconfig.enable = !isWSL && !pkgs.stdenv.isDarwin;

  programs.home-manager.enable = true;
}
