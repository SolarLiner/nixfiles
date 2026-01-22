return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
    },
    opts = {
      ensure_installed = "maintained",
      sync_install = false,
      indent = { enable = true },
      autopairs = { enable = true },
      rainbow = { enable = true },
      highlight = {
        -- `false` will disable the whole extension
        enable = true,
      },
      modules = {},
      ignore_install = {},
      auto_install = false,
      parser_install_dir = vim.call("stdpath", "data"),
    },
  },
}
