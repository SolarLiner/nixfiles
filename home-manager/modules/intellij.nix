{
  pkgs,
  ...
}: let
  inherit (pkgs) stdenv;
  toolboxPath =
    if stdenv.isDarwin
    then "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
    else "$HOME/.local/share/JetBrains/Toolbox/scripts";
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

      set switch
      nnoremap <leader>s :Switch<CR>
      nnoremap <leader>S :SwitchReverse<CR>

      set which-key
      set notimeout
      set timeoutlen=5000
    '';
  };
  programs.zsh.initContent = ''
    export PATH="${toolboxPath}:$PATH"
  '';
  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    JETBRAINS_TOOLBOX_HOME = toolboxPath;
  };
  home.sessionPath = ["${toolboxPath}/scripts"];
}
