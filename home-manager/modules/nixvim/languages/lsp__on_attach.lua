if client and client.server_capabilities.documentHighlightProvider then
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = event.buf,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = event.buf,
    callback = vim.lsp.buf.clear_references,
  })
end
