return {
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-ui",
    },
    config = function()
      require("dap-python").setup("uv")
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "python" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.ruff,
          null_ls.builtins.formatting.mypy,
        },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "debugpy",
        "mypy",
        "pyright",
        "ruff",
      },
    },
  },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-python"] = {},
      },
    },
  },
}
