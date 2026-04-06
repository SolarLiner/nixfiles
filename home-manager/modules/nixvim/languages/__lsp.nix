{
  lib,
  pkgs,
  ...
}: let
  utils = pkgs.callPackage ../utils.nix {};
  inherit (utils) mkNormal;
  inherit (lib.nixvim.utils) mkRaw;
  telescope = s: mkRaw ''require('telescope.builtin').${s}'';
  lsp = s: mkRaw "vim.lsp.buf.${s}";
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
  ];
}
