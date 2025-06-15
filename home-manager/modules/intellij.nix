{
  config,
  lib,
  pkgs,
  isWSL ? false,
  ...
}: let
  inherit (lib) mkIf;
  inherit (pkgs) stdenv;
in {
  home.file.".ideavimrc" = {
    text = ''
      set scrolloff=5
      set clipboard=unnamedplus
      set clipboard+=ideaput
      set command
      set commentary
      set easymotion
      set highlightedyank
      set incsearch
      set surround
    '';
  };
  programs.zsh.initContent = let
    toolboxPath =
      if stdenv.isDarwin
      then "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
      else "$HOME/.local/share/JetBrains/Toolbox/scripts";
  in ''
    export PATH="${toolboxPath}:$PATH"
  '';
  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    JETBRAINS_TOOLBOX_HOME = "$HOME/.local/share/JetBrains/Toolbox/";
  };
  home.sessionPath = ["$JETBRAINS_TOOLBOX_HOME/scripts"];
}
