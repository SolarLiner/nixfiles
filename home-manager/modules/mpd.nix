{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (pkgs) stdenv;
in {
  services.mpd = mkIf (!stdenv.isDarwin) {
    enable = true;
    musicDirectory = "/var/mnt/Nathan 1TB/Musiques/";
    network.listenAddress = "any";
  };
  services.mpdris2.enable = !stdenv.isDarwin;
}
