{
  lib,
  pkgs,
  ...
}: let
  tree-sitter-ipynb = pkgs.tree-sitter.buildGrammar {
    language = "ipynb";
    version = "0.0.0";
    src = "${pkgs.vimPlugins."ipynb-nvim".src}/tree-sitter-ipynb";
    meta.homepage = "https://github.com/ajbucci/ipynb.nvim/tree/main/tree-sitter-ipynb";
  };
in
  lib.nixvim.plugins.mkNeovimPlugin {
    name = "ipynb-nvim";
    moduleName = "ipynb";
    package = "ipynb-nvim";
    maintainers = [];
    # dependencies = [
    #   "gcc"
    #   "nodejs"
    #   "tree-sitter"
    # ];
    extraConfig = cfg: opt: {
      plugins.treesitter.grammarPackages = [
        tree-sitter-ipynb
      ];
    };
  }
