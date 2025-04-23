return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "cpp", "lua", "rust", "vim", "query", "wgsl" },
        sync_install = false,
        indent = { enable = true },
        autopairs = { enable = true },
        rainbow = { enable = true },
        highlight = {
          -- `false` will disable the whole extension
          enable = true,
        },
        modules = {},
        ignore_install = {},
        auto_install = false,
        parser_install_dir = vim.call("stdpath", "data")
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
    event = "BufEnter",
    cmd = {"TSContextEnable", "TSContextDisable", "TSContextToggle"},
    init = function ()
      vim.print("Treesitter Context")
      local augroup = vim.api.nvim_create_augroup("nvim-treesitter-context", { clear = true })
      vim.api.nvim_create_autocmd("BufEnter", {
        group = augroup,
        pattern = "*",
        callback = function ()
          vim.print("Enabling Treesitter Context")
          vim.cmd('TSContextEnable')
        end
      })
    end
  }
}
