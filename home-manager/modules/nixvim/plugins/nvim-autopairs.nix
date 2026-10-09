{
  plugins.nvim-autopairs = {
    enable = true;
    settings = {
      enable_moveright = true;
      check_ts = true;
      ts_config = {
        lua = ["string"];
        javascript = ["string" "template_string"];
        typescript = ["string" "template_string"];
        rust = ["type_parameters" "type_item" "reference_type" "lifetime"];
      };
    };
  };
}
