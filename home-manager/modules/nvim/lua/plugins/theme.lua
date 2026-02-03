return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "auto",
        background = {
          light = "latte",
          dark = "mocha",
        },
        styles = {
          comments = { "italic" },
          keywords = { "bold" },
        },
        transparent_background = not vim.g.neovide,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
