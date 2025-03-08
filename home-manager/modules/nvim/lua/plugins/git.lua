return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
    keys = {
      { "<leader>h", "<cmd>Gitsigns preview_hunk<cr>", "Preview hunk in tooptip" },
      { "<leader>b", "<cmd>Gitsigns blame_line<cr>", "Show blame for this line" }
    },
  },
}
