{ config, pkgs, lib, ... }:
with lib.modules;
let
  gnomeCfg = config.services.xserver.desktopManager.gnome;
in
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable a Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";

  environment.systemPackages = with pkgs; [
    plasma5Packages.breeze-gtk
    plasma5Packages.breeze-icons
    plasma5Packages.breeze-qt5
    libsForQt5.kdeconnect-kde
    gnome.adwaita-icon-theme
    gnome.gnome-tweaks
    adw-gtk3
    qogir-icon-theme
    gsound
  ];

  programs.gnome-terminal.enable = false;

  environment.gnome.excludePackages = with pkgs; [gnome-console];

  # Configure keymap in X11
  services.xserver = {
    layout = "fr";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  fonts.packages = with pkgs; [cantarell-fonts];
}
