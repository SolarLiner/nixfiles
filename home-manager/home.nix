{
  config,
  pkgs,
  lib,
  ...
}:
with lib.lists; let
  inherit (pkgs.stdenv) isLinux isDarwin;
  gl = config.nixGL.wrapper;
  isWSL = isLinux && !config.home.isGraphical;
in {
  imports = [../modules/home-manager/nixgl.nix ../modules/home-manager/environmentd.nix ../modules/home-manager/customization.nix];
  home.environmentd.enable = !isDarwin;
  nixGL.enable = !isDarwin;
  home.packages = with pkgs;
    [
      cmake
      ninja
      ccache
      sccache
      docker-compose
      git-crypt
    ]
    ++ optionals (!isWSL) [
      # Fonts
      jetbrains-mono
      iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      # Programs
      (gl gimp)
      localsend
    ]
    ++ optionals isWSL [curl wget]
    ++ optionals (!isDarwin) [ocenaudio];
  home.stateVersion = "25.05";

  fonts.fontconfig.enable = !isWSL && !isDarwin;

  programs.home-manager.enable = true;
  services.home-manager.autoExpire = {
    enable = isLinux;
    frequency = "weekly";
    store.cleanup = true;
    timestamp = "-14 days";
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg:
      builtins.elem (nixpkgs.lib.getName pkg) [
        "ocenaudio"
      ];
  };
}
