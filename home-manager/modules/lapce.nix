{
  config,
  pkgs,
  ...
}: let
  gl = config.lib.nixGL.wrap;
in {
  home.packages = [(gl pkgs.lapce)];
}
