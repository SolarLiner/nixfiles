{ lib, pkgs, ... }: {
  programs.topgrade = {
    enable = true;
    settings = {
      misc.assume_yes = true;
      misc.disable = ["brew" "flatpak"];
      set_title = true;
      commands = {
        "home-manager" = let
          extraTargets = lib.optionals pkgs.stdenv.isDarwin ["system"];
          targets = ["update" "home"] ++ extraTargets;
        in lib.strings.concatStringsSep " " (["make -C ~/.config/nixfiles/"] ++ targets);
      };
    };
  };
}
