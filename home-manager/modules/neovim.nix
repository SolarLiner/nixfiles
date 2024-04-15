{
  pkgs,
  lib,
  ...
}: let
in {
  home.packages = with pkgs;
    [
      nodePackages.browser-sync
      nixd
      nodePackages.diagnostic-languageserver
      nodePackages.eslint
      nodePackages.eslint_d
      nodePackages.pyright
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      sumneko-lua-language-server
      wgsl-analyzer
      clangd
    ]
    ++ lib.optionals (!pkgs.stdenv.isDarwin) [
      slint-lsp
      # Clipboard support
      xclip
      wl-clipboard
    ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = builtins.readFile ./nvim/init.lua;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];
  };
  home.file."./.config/nvim/lua/plugins" = {
    source = ./nvim/plugins;
    recursive = true;
  };
}
