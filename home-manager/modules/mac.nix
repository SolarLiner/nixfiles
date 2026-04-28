{
  inputs,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin;
in {
  imports = [inputs.mac-app-util.homeManagerModules.default];
  targets.darwin.linkApps.enable = isDarwin;
}
