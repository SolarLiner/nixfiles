{
  lib,
  pkgs,
  ...
}: {
  programs.topgrade = {
    enable = true;
    settings = {
      misc.assume_yes = true;
      misc.disable = ["brew_cask" "brew_formula" "flatpak" "home_manager" "node" "gem" "poetry" "mas"] ++ lib.optionals pkgs.stdenv.isDarwin ["system"];
    };
  };
}
