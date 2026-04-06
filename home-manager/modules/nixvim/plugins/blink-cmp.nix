{
  plugins.blink-cmp.enable = true;
  plugins.blink-cmp.settings = {
    keymap.preset = "super-tab";
    completion.accept.auto_brackets.enabled = true;
    completion.documentation.auto_show = true;
    appearance = {
      use_nvim_cmp_as_default = true;
      nerd_font_variant = "normal";
    };
    signature.enabled = true;
  };
}
