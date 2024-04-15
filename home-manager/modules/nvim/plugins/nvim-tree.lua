return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        system_open = {
          cmd = "xdg-open",
        },
        diagnostics = {
          enable = true,
        },
        git = {
          enable = true,
          ignore = false,
        },
        filters = {
          custom = {
            [[\\.git]],
            [[node_modules]],
          },
        },
        renderer = {
          special_files = {
            "LICENSE",
            "README.md",
            "Cargo.toml",
            "Makefile",
          },
        },
      })

      vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function()
          require("nvim-tree.api").tree.open()
        end,
      })

      vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", {
        desc = "Tree [E]xplorer toggle",
      })
    end,
  },
}
