return {
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup({
        options = {
          numbers = "buffer_id",
          name_formatter = function(buf)
            if buf.name:match("%.md") then
              return vim.fn.fnamemodify(buf.name, ":t:r")
            end
          end,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          buffer_close_icon = "x",
          close_command = "bdelete %d",
          close_icon = "x",
          indicator = {
            style = "icon",
            icon = " ",
          },
          left_trunc_marker = "",
          modified_icon = "●",
          offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
          right_mouse_command = "bdelete! %d",
          right_trunc_marker = "",
          show_close_icon = false,
          show_tab_indicators = true,
        },
      })
    end,
  },
}
