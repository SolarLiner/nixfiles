{
  plugins.auto-save.enable = true;
  plugins.auto-save.settings = {
    condition.__raw = ''
      function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        if utils.not_in(fn.getbufvar(buf, "&filetype"), {"oil"}) then
          return true
        end
        return false
      end
    '';
  };
}
