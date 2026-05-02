{pkgs, ...}: {
  home.packages = with pkgs; [gnumake cmake ninja meson gcc];
}
