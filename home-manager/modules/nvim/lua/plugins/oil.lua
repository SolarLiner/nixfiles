return {
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    keys = {
      { "<leader>-", "<cmd>Oil<CR>", desc = "[-] Open file browser (oil)" },
    },
  },
}
