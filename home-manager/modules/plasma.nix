{pkgs, ...}: {
  import = [./plasma.generated.nix];
  home.packages = with pkgs; [iosevka inter];
}
