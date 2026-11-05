{pkgs, ...}: {
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [neovim];
  nix.settings.trusted-users = ["solarliner"];
  users.users.solarliner = {
    hashedPassword = "$y$j9T$KodkvV5yYQ6ABLdJtFSUX1$wFhVd9LRE9zJ2/gwZJ./2d.agI63nqBWH2m7VtkFRD3";
    isNormalUser = true;
    createHome = true;
    description = "Nathan Graule";
    extraGroups = ["networkmanager" "wheel" "audio" "video" "docker"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPrvb1L/ac5WVF6Eq6hL1Wqvdm5NRAzUELHbgRlNPdmS me@solarliner.dev"
    ];
  };
}
