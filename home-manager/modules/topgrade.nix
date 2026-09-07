{
  lib,
  pkgs,
  ...
}: {
  programs.topgrade = {
    enable = true;
    settings = {
      misc.assume_yes = true;
      misc.disable = ["brew_cask" "brew_formula" "containers" "flatpak" "home_manager" "node" "gem" "pipx" "poetry" "mas"] ++ lib.optionals pkgs.stdenv.isDarwin ["system"];
    };
  };
}
