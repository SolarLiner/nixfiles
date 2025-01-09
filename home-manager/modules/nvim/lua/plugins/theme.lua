return {
  {
    "Mofiqul/vscode.nvim",
    name = "vscode",
    config = function()
      vim.opt.background = "dark"

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
    end,
  },
}
