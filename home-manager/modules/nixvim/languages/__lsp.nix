{
  lib,
  pkgs,
  ...
}: let
  utils = pkgs.callPackage ../utils.nix {};
  inherit (utils) mkNormal cmd;
  inherit (lib.nixvim.utils) mkRaw;
  telescope = s: mkRaw ''require('telescope.builtin').${s}'';
  lsp = s: mkRaw "vim.lsp.buf.${s}";
  diag = s: mkRaw "vim.diagnostic.${s}";
  diagmove = dir: mkRaw ''function() vim.diagnostic.jump({ count = ${dir}, float = true }) end'';
in {
  plugins.lspconfig.enable = true;
  lsp.onAttach = builtins.readFile ./lsp__on_attach.lua;
  keymaps = [
    (mkNormal "gd" (telescope "lsp_definitions") {desc = "[G]oto [D]efinition";})
    (mkNormal "gr" (telescope "lsp_references") {desc = "[G]oto [R]erefences";})
    (mkNormal "gI" (telescope "lsp_implementations") {desc = "[G]oto [I]mplementation";})
    (mkNormal "<leader>D" (telescope "lsp_type_definitions") {desc = "Type [D]efinition";})
    (mkNormal "<leader>ds" (telescope "lsp_document_symbols") {desc = "[D]ocument [S]ymbols";})
    (mkNormal "<leader>ws" (telescope "lsp_dynamic_workspace_symbols") {desc = "[W]orkspace [S]ymbols";})
    (mkNormal "<leader>rn" (lsp "rename") {desc = "[R]e[n]ame";})
    (mkNormal "<leader>ca" (lsp "code_action") {desc = "[C]ode [A]ctions";})
    (mkNormal "K" (lsp "hover") {desc = "Hover Documentation";})
    (mkNormal "gD" (lsp "declaration") {desc = "[G]oto [D]eclaration";})
    (mkNormal "(d" (diagmove "-1") {desc = "Previous [D]iagnostic";})
    (mkNormal ")d" (diagmove "1") {desc = "Next [D]iagnostic";})
    (mkNormal "<leader>e" (diag "open_float") {desc = "Show [E]error under cursor";})
    (mkNormal "<leader>q" (diag "setloclist") {desc = "Diagnostic [Q]uickfix list";})
    (mkNormal "<leader>f" (lsp "format") {desc = "[F]ormat Document/Selection";})
    (mkNormal "<leader>(" (cmd "cprev") {desc = "Prev Quickfix Entry";})
    (mkNormal "<leader>)" (cmd "cnext") {desc = "Next Quickfix Entry";})
  ];
}
