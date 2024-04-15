return {
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.keymap.set("n", "<leader>-", "<cmd>Oil<CR>", { desc = "Open file browser (oil)" })
    end,
  },
}
