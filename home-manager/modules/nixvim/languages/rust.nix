{
  plugins.crates.enable = true;

  lsp.servers.rust_analyzer.enable = true;
  lsp.servers.rust_analyzer.packageFallback = true;
  plugins.lsp.servers.rust_analyzer.enable = true;
  plugins.lsp.servers.rust_analyzer.packageFallback = true;
  plugins.lsp.servers.rust_analyzer.installCargo = false;
  plugins.lsp.servers.rust_analyzer.installRustc = false;

  plugins.rustaceanvim.enable = false; # TODO: re-enable once we can use `dependencies.rust-analyzer.packageFallback = true`;
  plugins.rustaceanvim.settings = {
    tools.on_initialized.__raw = ''
      function(_health)
        vim.keymap.set("n", "<leader>rc", function()
          vim.cmd.RustLsp("openCargo")
        end, {
          desc = "[R]ust open [C]argo.toml",
        })
        vim.keymap.set("n", "<leader>rr", function()
          vim.cmd.RustLsp("runnables")
        end, {
          desc = "[R]ust [R]unnables",
        })
        vim.keymap.set("n", "<leader>rR", function()
          vim.cmd.RustLsp("run")
        end, {
          desc = "[R]ust [R]un target under cursor",
        })
        vim.keymap.set("n", "<leader>rt", function()
          vim.cmd.RustLsp("testables")
        end, {
          desc = "[R]ust [T]ests",
        })
        vim.keymap.set("n", "<leader>ca", function()
          vim.cmd.RustLsp("codeAction")
        end, {
          desc = "[C]ode [A]ctions",
        })
      end
    '';
  };
  plugins.neotest.adapters.rust.enable = true;
}
