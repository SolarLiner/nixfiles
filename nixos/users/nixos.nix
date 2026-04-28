{pkgs, ...}: {
  programs.zsh.enable = true;
  nix.settings.trusted-users = ["nixos"];
  users.users.nixos = {
    hashedPassword = "$y$j9T$KodkvV5yYQ6ABLdJtFSUX1$wFhVd9LRE9zJ2/gwZJ./2d.agI63nqBWH2m7VtkFRD3";
    isNormalUser = true;
    createHome = true;
    description = "NixOS";
    extraGroups = ["networkmanager" "wheel" "audio" "video" "docker"];
    shell = pkgs.zsh;
  };
}
