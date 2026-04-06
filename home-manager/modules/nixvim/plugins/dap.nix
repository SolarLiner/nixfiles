{
  lib,
  pkgs,
  ...
}: let
  utils = pkgs.callPackage ../utils.nix {};
  inherit (utils) mkNormal;
  inherit (lib.nixvim) mkRaw;
  dapui = s: mkRaw "require('dapui').${s}";
in {
  plugins.dap.enable = true;
  plugins.dap-ui.enable = true;
  plugins.dap-virtual-text.enable = true;
  plugins.dap-lldb.enable = true;
  plugins.dap-lldb.settings.codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";

  plugins.lazydev.settings.library = ["nvim-dap-ui"];
  plugins.dap.luaConfig.post = builtins.readFile ./dap__lua_config.lua;

  keymaps = [
    (mkNormal "<leader>dd" "<cmd>DapNew<CR>" {desc = "Start [Dd]ebugging";})
    (mkNormal "<leader>db" "<cmd>DapToggleBreakpoint<CR>" {desc = "[D]ebug [B]reakpoint";})
    (mkNormal "<leader>dt" "<cmd>DapTerminate<CR>" {desc = "[D]ebug [T]erminate";})
    (mkNormal "<leader>de" (dapui "eval") {desc = "[D]ebug [E]val";})
  ];
}
