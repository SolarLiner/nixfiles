{pkgs, ...}: {
  programs.nixvim.imports = [./nixvim/default.nix ../../modules/nixvim.nix];

  home.packages = with pkgs; [neovim-remote];

  programs.zsh.initContent = ''
    if [[ "x''${NVIM}" != "x" ]]; then
      function nvim_open {
        nvr --servername "''${NVIM}" --remote-tab-wait "+set bufhidden=delete" ''${1}
      }
      function nvim_with_server {
        nvr --servername "''${NVIM}" ''${@}
      }
      export VISUAL=nvim_open
      export EDITOR=nvim_open
      export GIT_EDITOR=nvim_open
      alias v=nvim_with_server
      alias vi=nvim_with_server
      alias vim=nvim_with_server
      alias nvim=nvim_with_server
    fi
  '';
}
