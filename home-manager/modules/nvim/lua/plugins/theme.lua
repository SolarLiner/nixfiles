return {
  {
    "Mofiqul/vscode.nvim",
    name = "vscode",
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
