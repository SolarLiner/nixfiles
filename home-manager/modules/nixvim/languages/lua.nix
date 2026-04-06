{
  lsp.servers.lua-language-server.enable = true;
  lsp.servers.stylua.enable = true;

  plugins.lazydev.enable = true;
  plugins.blink-cmp.settings.sources.providers.lazydev = {
    name = "LazyDev";
    module = "lazydev.integrations.blink";
    score_offset = 100;
  };
}
