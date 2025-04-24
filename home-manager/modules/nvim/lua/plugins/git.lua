return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
      current_line_blame = true,
    },
    keys = {
      {
        "<leader>gh",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview hunk in tooptip",
      },
      {
        "<leader>gb",
        function()
          require("gitsigns").blame_line()
        end,
        desc = "Show blame for this line",
      },
      {
        "<leader>gd",
        function ()
          require("gitsigns").diffthis()
        end,
        "Diff this",
      },
      {
        "<leader>gD",
        function ()
          require("gitsigns").diffthis("~")
        end,
        desc = "Diff this against the index",
      },
      {
        "<leader>gs",
        function ()
          local start = vim.fn.line('.')
          local end_ = vim.api.line('v')
          require("gitsigns").stage_hunk({ start, end_ })
        end,
        desc = "Stage hunk",
      },
      {
        "<leader>gr",
        function (bufnr)
          local start = vim.fn.line('.')
          local end_ = vim.api.line('v')
          require("gitsigns").reset_hunk({ start, end_ })
        end,
        desc = "Reset hunk",
      },
      {
        "<leader>gS",
        function ()
          require("gitsigns").stage_buffer()
        end,
        desc = "Stage buffer",
      },
      {
        "<leader>gR",
        function ()
          require("gitsigns").reset_buffer()
        end,
        desc = "Reset buffer",
      }
    },
  },
}
