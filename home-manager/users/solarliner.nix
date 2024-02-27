{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../configs/all.nix
  ];
  home = {
    username = "solarliner";
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/solarliner"
      else "/home/solarliner";
  };
  programs.git = {
    userName = "Nathan Graule";
    userEmail = "solarliner@gmail.com";
  };
}
