{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.lldb.lldbinit;
  enable = config.programs.lldb.enable && cfg.enable;
  lldbinit = pkgs.fetchFromGitHub {
    owner = "gdbinit";
    repo = "lldbinit";
    rev = "v3.2";
    hash = "sha256-gjwTu4UASwVvpGXnICByLUBnVyfwhJsAn9CW40ZsHw4=";
  };
in {
  options.programs.lldb.lldbinit = {
    enable = mkEnableOption "dave";
  };

  config = mkIf enable {
    programs.lldb.initContent = ''
      command script import ${lldbinit}/lldbinit.py
    '';
  };
}
