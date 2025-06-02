{pkgs, inputs, ...}: {
  imports = [inputs.plasma-manager.homeManagerModules.plasma-manager ./plasma.generated.nix];
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    inter
  ];
}
