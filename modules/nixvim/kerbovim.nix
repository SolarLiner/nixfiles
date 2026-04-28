{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.kerbovim;
  lsp = config.lsp.servers.kos-language-server;
  inherit (pkgs.vimUtils) buildVimPlugin;
  inherit (lib.nixvim) defaultNullOpts mkNullOrOption;
  isEnabled = x: (x.enable != null && x.enable);

  kos-language-server = pkgs.callPackage ../../pkgs/kos-language-server.nix {};
in {
  options.kerbovim = {
    enable = defaultNullOpts.mkBool false ''
      Enable or disable the kerbovim plugin, which provides syntax highlighting for kOS.
    '';
  };
  config = {
    extraPackages = lib.mkIf (isEnabled lsp) [kos-language-server];
    extraPlugins = lib.mkIf (isEnabled cfg) [
      (buildVimPlugin {
        name = "kerbovim";
        src = pkgs.fetchFromGitHub {
          owner = "Freedzone";
          repo = "kerbovim";
          rev = "c6bdc3a19e0b84085113dafb5b4ab6bf668c698b";
          hash = "sha256-2lzHOGZe7rizPayFsI16+FVNWlm+3yITQlc4NhjsFRM=";
        };
      })
    ];
    lsp.servers.kos-language-server = {
      config = {
        cmd = ["kls"];
        filetypes = ["ks" "kerboscript"];
      };
    };
  };
}
