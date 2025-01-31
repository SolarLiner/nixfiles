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
  home.environmentd.enable = !isDarwin;
  nixGL.enable = !isDarwin;
  home.packages = with pkgs;
    [
      ccache
      docker-compose
      git-crypt
    ]
    ++ optionals (!isWSL) [
      # Fonts
      jetbrains-mono
      iosevka
      nerd-fonts
      # Programs
      (gl gimp)
    ]
    ++ optionals isWSL [curl wget]
    ++ optionals (!isDarwin) [ocenaudio];
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
