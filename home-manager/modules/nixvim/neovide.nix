{pkgs, ...}: let
  inherit (pkgs) stdenv;
  font-size-int =
    if stdenv.hostPlatform.isDarwin
    then 13
    else 10;
  font-size = toString font-size-int;
  guifont = "Iosevka:h${font-size}";
in {
  neovide.configLua = ''
    vim.cmd.set "guifont=${guifont}"
  '';
}
