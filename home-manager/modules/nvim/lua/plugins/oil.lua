return {
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        -- "permissions",
        "size",
        "mtime",
      },
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
        natural_order = "fast",
        is_hidden_file = function ()
          return false
        end
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    keys = {
      { "<leader>-", "<cmd>Oil<CR>", desc = "[-] Open file browser (oil)" },
    },
  },
}
