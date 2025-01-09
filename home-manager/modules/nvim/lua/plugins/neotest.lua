return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "folke/lazydev.nvim", opts = { library = { { plugins = { "neotest" }, types = true } } } },
      -- Adapters
      "nvim-neotest/neotest-python",
      "mrcjkb/rustaceanvim",
      "lawrence-laz/neotest-zig",
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
        ["neotest-zig"] = { dap = { adapters = "lldb" } },
        ["neotest-vitest"] = {},
        ["neotest-python"] = {},
      },
    },
  },
}
