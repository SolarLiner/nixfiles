{
  config,
  lib,
  pkgs,
  isWSL ? false,
  ...
}:
with lib; {
  home.packages = with pkgs; [
    nixfmt-rfc-style
    nixd
  ];
  home.file.".vscode-server/server-env-setup" = mkIf isWSL {
    source = ./vscode/server-env-setup.sh;
    target = ".vscode-server/server-env-setup";
    executable = true;
  };
  xdg.configFile."environment.d/10-electron.conf" = mkIf (!isWSL) {
    text = ''
      ELECTRON_OZONE_PLATFORM_HINT=auto
    '';
  };
}
