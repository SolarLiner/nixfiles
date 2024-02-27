{
  pkgs,
  lib,
  ...
}:
with pkgs;
with vimUtils;
with lib;
  buildVimPlugin {
    name = "web-tools";
    src = pkgs.fetchFromGitHub {
      repo = "web-tools.nvim";
      owner = "ray-x";
      rev = "b55bc15c8a640d7e7704c25550b1314bb5d0da92";
      sha256 = "sha256-lr223egv1sBS5HZDFcfy3KMKiHhFFJK7J//AG1Jd6QI=";
    };
  }
