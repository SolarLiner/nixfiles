return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        sync_install = false,
        indent = { enable = true },
        autopairs = { enable = true },
        rainbow = { enable = true },
        highlight = {
          -- `false` will disable the whole extension
          enable = true,
        },
      })
    end,
  },
}
