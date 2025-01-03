{
  pkgs,
  lib,
  ...
}: {
  programs.zsh.enable = true;

  users.users.solarliner = {
    hashedPassword = "$y$j9T$KodkvV5yYQ6ABLdJtFSUX1$wFhVd9LRE9zJ2/gwZJ./2d.agI63nqBWH2m7VtkFRD3";
    isNormalUser = true;
    createHome = true;
    description = "Nathan Graule";
    extraGroups = ["networkmanager" "wheel" "audio" "video" "docker"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Basic
      home-manager
      # Wine
      wineWowPackages.waylandFull
      winetricks
      wineasio
      # Programming
      kate
      vscode-fhs
      jetbrains-toolbox
      # Audio
      yabridge
      yabridgectl
      carla
      cardinal
      distrho
      vcv-rack
      vital
      surge-XT
      stochas
      lsp-plugins
      calf
      plugdata
    ];
  };
}
