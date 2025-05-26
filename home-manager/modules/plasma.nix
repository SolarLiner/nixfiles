{pkgs, ...}: {
  imports = [./plasma.generated.nix];
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    inter
  ];
}
