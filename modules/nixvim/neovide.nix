{
  lib,
  config,
  ...
}: let
  cfg = config.neovide;
  enable = cfg.configLua != "";
in {
  options.neovide = {
    configLua = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra configuration only executed when using Neovide";
    };
  };
  config = lib.mkIf enable {
    extraConfigLua = ''
      if vim.g.neovide then
        ${cfg.configLua}
      end
    '';
  };
}
