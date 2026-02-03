{pkgs, ...}: {
  home = {
    username = "solarliner";
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/solarliner"
      else "/home/solarliner";
  };
  programs.git.settings.user = {
    name = "Nathan Graule";
    email = "solarliner@gmail.com";
  };
}
