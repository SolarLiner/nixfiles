{pkgs, ...}: {
  imports = [./plasma.generated.nix];
  home.packages = with pkgs; [iosevka inter latte-dock];
}
