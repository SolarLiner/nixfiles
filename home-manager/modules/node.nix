{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs
    corepack
  ];
  programs.zsh.initContent = ''
    # Node
    export NPM_GLOBAL=''${XDG_DATA_HOME:-~/.local/share}/npm-global
    if [[ ! -e $NPM_GLOBAL ]]; then
      mkdir -p $NPM_GLOBAL
      npm config set prefix $NPM_GLOBAL
    fi
    export PATH="$NPM_GLOBAL/bin:$PATH"
  '';
}
