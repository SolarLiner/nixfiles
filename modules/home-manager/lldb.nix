{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.lldb;
in {
  options.programs.lldb = {
    enable = mkEnableOption "LLDB";
    package = mkPackageOption pkgs "lldb" {};
    initContent = mkOption {
      default = "";
      type = types.lines;
    };
  };
  config = mkIf cfg.enable {
    home.file.".lldbinit".text = cfg.initContent;
    home.packages = [cfg.package];
  };
}
