{
  config,
  pkgs,
  lib,
  ...
}:
with lib.lists; let
  inherit (pkgs.stdenv) isLinux isDarwin;
  gl = config.lib.nixGL.wrap;
  isWSL = isLinux && !config.home.isGraphical;
  imports = lib.attrsets.attrValues (import ../modules/home-manager);
in {
  inherit imports;
  home.environmentd.enable = !isDarwin;
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
      localsend
    ]
    ++ optionals isWSL [curl wget]
    ++ optionals (!isDarwin) [ocenaudio (gl gimp)];
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
