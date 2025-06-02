{pkgs, ...}: {
  imports = [
    ../configs/mac.nix
  ];
  home = {
    username = "nathangraule";
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/nathangraule"
      else "/home/nathangraule";
  };
  programs.git = {
    userName = "Nathan Graule";
    userEmail = "nathan.graule@arturia.com";
  };
}
