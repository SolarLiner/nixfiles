{pkgs, ...}: {
  programs.zsh.initContent = ''
    # Pyenv
    if [[ ! -e $PYENV_ROOT ]]; then
      git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
    fi
    eval "$(pyenv init - path)"
  '';
  home.sessionVariables = {
    PYENV_ROOT = "$HOME/.local/share/pyenv";
  };
  home.sessionPath = ["$PYENV_ROOT/bin"];
}
