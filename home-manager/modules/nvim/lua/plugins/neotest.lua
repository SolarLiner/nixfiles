return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "folke/lazydev.nvim", opts = { library = { { plugins = { "neotest" }, types = true } } } },
    },
    opts = function()
      return {
        adapters = require("rustaceanvim.neotest"),
      }
    end,
  },
}
