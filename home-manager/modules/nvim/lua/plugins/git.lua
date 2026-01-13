return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
      current_line_blame = true,
    },
    keys = {
      {
        "<leader>hh",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview hunk in tooptip",
      },
      {
        "<leader>hb",
        function()
          require("gitsigns").blame_line()
        end,
        desc = "Show blame for this line",
      },
      {
        "<leader>hd",
        function()
          require("gitsigns").diffthis()
        end,
        "Diff this",
      },
      {
        "<leader>hD",
        function()
          require("gitsigns").diffthis("~")
        end,
        desc = "Diff this against the index",
      },
      {
        "<leader>hs",
        function()
          if vim.fn.mode() == "v" then
            local start = vim.fn.line(".")
            local end_ = vim.api.line("v")
            require("gitsigns").stage_hunk({ start, end_ })
          else
            require("gitsigns").stage_hunk()
          end
        end,
        desc = "Stage hunk",
      },
      {
        "<leader>hr",
        function ()
          if vim.fn.mode() == "v" then
            local start = vim.fn.line(".")
            local end_ = vim.api.line("v")
            require("gitsigns").reset_hunk({ start, end_ })
          else
            require("gitsigns").reset_hunk()
          end
        end,
        desc = "Reset hunk",
      },
      {
        "<leader>hS",
        function()
          require("gitsigns").stage_buffer()
        end,
        desc = "Stage buffer",
      },
      {
        "<leader>hR",
        function()
          require("gitsigns").reset_buffer()
        end,
        desc = "Reset buffer",
      },
    },
  },
}
