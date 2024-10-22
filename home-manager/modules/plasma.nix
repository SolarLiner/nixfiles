{pkgs, ...}: {
  imports = [./plasma.generated.nix];
  home.packages = with pkgs; [iosevka nerd-fonts inter];
}
