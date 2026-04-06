{
  lib,
  pkgs,
  ...
}: {
  imports = let
    loadNixFiles = folder:
      lib.lists.filter
      (lib.strings.hasSuffix ".nix")
      (lib.filesystem.listFilesRecursive folder);
    plugins = loadNixFiles ./plugins;
    languages = loadNixFiles ./languages;
    config = [./term.nix];
  in
    plugins ++ languages ++ config;

  enable = true;
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
  defaultEditor = true;

  diagnostic.settings = {
    virtual_text = false;
    virtual_lines = true;
  };

  editorconfig.enable = true;
  luaLoader.enable = true;
  match.ExtraWhitespace = "\\s\\+$"; # Remove extra white spaces

  colorschemes.catppuccin.enable = true;

  # Opts
  globals = rec {
    mapleader = " ";
    maplocalleader = mapleader;
  };
  keymaps = let
    utils = pkgs.callPackage ./utils.nix {};
    inherit (utils) mkNormal mkKeymap;
  in [
    (mkNormal " " "<Nop>" {
      desc = "Ignore space";
      silent = true;
    })
    (mkNormal "<esc>" "<cmd>nohl<CR>" {
      desc = "Clear search highlight";
      silent = true;
    })
    (mkNormal "<C-h>" "<C-w><C-h>" {desc = "Move to left pane";})
    (mkNormal "<C-l>" "<C-w><C-l>" {desc = "Move to right pane";})
    (mkNormal "<C-j>" "<C-w><C-j>" {desc = "Move to lower pane";})
    (mkNormal "<C-k>" "<C-w><C-k>" {desc = "Move to upper pane";})
    (mkKeymap ["n" "v"] "<leader>y" ''"+y'' {
      desc = "System [Y]ank";
      silent = true;
    })
    (mkKeymap ["n" "v"] "<leader>p" ''"+p'' {
      desc = "System [P]aste";
      silent = true;
    })
    (mkKeymap ["n" "v"] "<leader>P" ''"+P'' {
      desc = "System [P]aste";
      silent = true;
    })
    (mkKeymap "t" "<esc><esc>" "<C-\\><C-n>" {
      desc = "Escape from Terminal";
      silent = true;
    })
  ];
  opts = {
    colorcolumn = "100"; # Columns to highlight
    cursorline = true; # Highlight the screen line of the cursor
    fileencoding = "utf-8"; # File-content encoding for the current buffer
    hidden = true; # Keep closed buffer open in the background
    ignorecase = true; # When the search query is lower-case, match both lower and upper-case patterns
    incsearch = true; # Incremental search: show match for partly typed search command
    laststatus = 3; # When to use a status line for the last window
    modeline = true; # Tags such as 'vim:ft=sh'
    modelines = 100; # Sets the type of modelines
    mouse = "a"; # Enable mouse control
    mousemodel = "popup"; # Enable right-click popup
    number = true; # Display the absolute line number of the current line
    relativenumber = true; # Relative line numbers
    scrolloff = 5; # 5 lines of context above and below the cursor when scrolling
    signcolumn = "yes"; # Whether to show the signcolumn
    smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper case characters
    spell = true; # Highlight spelling mistakes (local to window)
    spelllang = lib.mkDefault ["en_us" "fr"]; # Spell check languages
    splitbelow = true; # A new window is put below the current one
    splitright = true; # A new window is put right of the current one
    termguicolors = true; # Enables 24-bit RGB color in the |TUI|
    timeoutlen = 300; # Decrease chord timeout (makes which-key display sooner)
    undofile = true; # Automatically save and restore undo history
    updatetime = 250;
    wrap = false; # Prevent text from wrapping
  };
}
