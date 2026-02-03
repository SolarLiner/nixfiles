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
  programs.git.settings.user = {
    name = "Nathan Graule";
    email = "nathan.graule@arturia.com";
  };
}
