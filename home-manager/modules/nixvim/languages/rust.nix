{
  plugins.rustaceanvim.enable = true;
  plugins.rustaceanvim.settings = {
    tools.on_initialized.__raw = builtins.readFile ./rust__on_initialized.lua;
  };
  plugins.neotest.adapters.rust.enable = true;
}
