{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs;
    [
      #nodePackages.browser-sync
      nixd
      nodePackages.diagnostic-languageserver
      #nodePackages.eslint
      #nodePackages.eslint_d
      #nodePackages.pyright
      nodePackages.typescript
      nodePackages.typescript-language-server
      unstable.nodePackages.vscode-langservers-extracted
      sumneko-lua-language-server
      #wgsl-analyzer
      #clangd
      zig
      fzf
      unzip
    ]
    ++ lib.optionals (!pkgs.stdenv.isDarwin) [
      slint-lsp
      # Clipboard support
      xclip
      wl-clipboard
    ];
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = builtins.readFile ./nvim/init.lua;
    #defaultEditor = true; # Deactivated: sudo -e needs absolute path
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];
    extraPackages = with pkgs; [zig fzf nodejs unzip];
  };
  home.file."./.config/nvim/lua/plugins" = {
    source = ./nvim/lua/plugins;
    recursive = true;
  };
  home.sessionVariables = { EDITOR = "${config.programs.neovim.package}/bin/nvim"; };
}
