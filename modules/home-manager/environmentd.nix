{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.home.environmentd;
  genEnvdFile = variables: strings.concatStringsSep "\n" (attrsets.mapAttrsToList (name: value: "${name}=${value}") variables);
  sessionPathAttrset = let
    userPaths = strings.concatStringsSep ":" config.home.sessionPath;
  in
    if builtins.stringLength userPaths > 0
    then {PATH = "${userPaths}:$PATH";}
    else {};
in {
  options.home.environmentd = {
    enable = mkEnableOption "environment.d";
    output = mkOption {
      type = types.str;
      internal = true;
      default = "";
      description = "Output environment file added to $XDG_CONFIG_DIR/environment.d/";
    };
  };
  config = mkIf cfg.enable {
    home.environmentd.output = genEnvdFile (config.home.sessionVariables // sessionPathAttrset);
    xdg.configFile."environment.d/99-home-manager-variables.conf" = {
      text = config.home.environmentd.output;
    };
  };
}
