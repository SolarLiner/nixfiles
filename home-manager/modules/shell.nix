{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  zsh-256color = rec {
    name = "zsh-256color";
    file = "${name}.plugin.zsh";
    src = pkgs.fetchFromGitHub {
      repo = "zsh-256color";
      owner = "chrissicool";
      rev = "9d8fa1015dfa895f2258c2efc668bc7012f06da6";
      sha256 = "Qd9pjDSQk+kz++/UjGVbM4AhAklc1xSTimLQXxN57pI=";
    };
  };
  zsh-autopair = {
    inherit (pkgs.zsh-autopair) name src;
    file = "autopair.plugin.zsh";
  };
  zsh-you-should-use = {
    inherit (pkgs.zsh-you-should-use) name src;
    file = "you-should-use.plugin.zsh";
  };
  zsh-vi-mode = {
    inherit (pkgs.zsh-vi-mode) name src;
    file = "you-should-use.plugin.zsh";
  };
in {
  home.packages = with pkgs; [
    docker-buildx
    docker-compose
    tree
    jq
    jiq
    ripgrep
    htop
    fastfetch
    pv
    kubeseal
    nix-output-monitor
    pre-commit
  ];
  home.sessionVariables = {
    VISUAL = config.home.sessionVariables.EDITOR;
  };
  programs.autojump.enable = true;
  programs.bat = {
    enable = true;
    extraPackages =
      with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
    syntaxes = lib.mkForce {};
  };
  programs.eza.enable = true;
  programs.bash.enable = false;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.nushell = {
    enable = true;
    plugins = lib.attrsets.attrVals ["query" "skim" "units" "formats" "polars"] pkgs.nushellPlugins;
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [zsh-256color zsh-autopair zsh-you-should-use zsh-vi-mode];
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "sudo" "rust" "autojump" "vscode"];
    };
    shellAliases = mkIf config.programs.zellij.enable {
      zr = "zellij run --";
      ze = "zellij edit --";
      za = "zellij action";
    };
  };
  home.sessionVariables = {
    NIX_PATH=''$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH'';
  };
  home.sessionPath = ["$HOME/.nix-profile/bin" "$HOME/.local/bin"];
  # services.google-drive-ocamlfuse.enable = false; # Disabled while waiting for dev to re-enable authentication
}
