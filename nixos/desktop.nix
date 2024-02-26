{ ... }:
{
  # Windowing
  services.xserver.enable = true;

  # Desktop environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Desktop software
  services.flatpak.enable = true;
}