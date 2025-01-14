{
  config,
  pkgs,
  lib,
  isWSL ? false,
  ...
}:
with lib.lists; let
  inherit (pkgs.stdenv) isDarwin;
  gl = config.nixGL.wrapper;
in {
  nixGL.enable = !isDarwin;
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
      (gl gimp)
      ocenaudio
    ]
    ++ optionals isWSL [curl wget];
  home.stateVersion = "23.11";

  fonts.fontconfig.enable = !isWSL && !isDarwin;

  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg:
      builtins.elem (nixpkgs.lib.getName pkg) [
        "ocenaudio"
      ];
  };
}
