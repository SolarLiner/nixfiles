{ config, pkgs, ... }: let gl = config.nixGL.wrapper; in {
  home.packages = [ (gl pkgs.lapce) ];
}

