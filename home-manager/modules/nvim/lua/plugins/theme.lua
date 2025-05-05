return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function ()
      require("catppuccin").setup {
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
      }
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    name = "vscode",
    enabled = false,
    config = function()
      vim.opt.background = "dark"

      local colors = require("vscode.colors").get_colors()

      require("vscode").setup({
        -- Enable transparent background
        transparent = true,
        -- Enable italic comment
        italic_comments = true,
        -- Underline `@markup.link.*` variants
        underline_links = true,
        -- Disable nvim-tree background color
        disable_nvimtree_bg = true,
      })

      vim.cmd.colorscheme("vscode")
      -- Support for blink ghost text feature
      vim.api.nvim_set_hl(0, "NonText", { fg = colors["vscDimHighlight"] })
      vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { fg = colors["vscDimHighlight"] })
    end,
  },
}
