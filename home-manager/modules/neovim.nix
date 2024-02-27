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
    extraConfig = ''
      luafile ${./nvim/init.lua}
      luafile ${./nvim/tree-sitter.lua}

      lua << EOF
      vim.defer_fn(function()
      vim.cmd [[
        luafile ${./nvim/cmp.lua}
        luafile ${./nvim/lspconfig.lua}
        luafile ${./nvim/bufferline.lua}
        luafile ${./nvim/lualine.lua}
        luafile ${./nvim/neorg.lua}
        luafile ${./nvim/nvim-tree.lua}
        luafile ${./nvim/toggleterm.lua}
        luafile ${./nvim/telescope.lua}
      ]]
      end, 70)
      EOF
    '';
    plugins = with pkgs.vimPlugins;
    with pkgs.extraVimPlugins; [
      vim-surround
      indentLine
      luasnip
      {
        plugin = nvim-autopairs;
        config = "lua require'nvim-autopairs'.setup{}";
      }
      {
        plugin = vim-auto-save;
        config = ''
          let g:auto_save = 1
          let g:auto_save_silent = 1
          let g:auto_save_events = ["InsertLeave", "TextChanged"]
        '';
      }
      nvim-web-tools

      # Colortheme
      {
        plugin = vscode-nvim;
        config = ''
          luafile ${./nvim/colortheme.lua}
        '';
      }

      # Filetypes
      (nvim-treesitter.withPlugins (plugins:
        pkgs.tree-sitter.allGrammars
        ++ [pkgs.vimPlugins.nvim-treesitter-parsers.wgsl_bevy]))
      vim-nix
      vim-glsl

      # LSP
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lsp-document-symbol
      cmp-nvim-lsp-signature-help
      cmp_luasnip
      lspkind-nvim

      # UI
      {
        plugin = dressing-nvim;
        config = "lua require'dressing'.setup {}";
      }
      nvim-web-devicons
      nvim-tree-lua
      popup-nvim
      plenary-nvim
      telescope-nvim
      bufferline-nvim
      lualine-nvim
      toggleterm-nvim

      # Neorg
      #neorg
    ];
  };
  programs.zsh = {sessionVariables = {EDITOR = "nvim";};};
}
