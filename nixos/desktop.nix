{pkgs, ...}: {
  programs = {
    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
  };

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      # desktopManager.gnome.enable = true;
      desktopManager = {
        gnome = {
          enable = true;
          extraGSettingsOverrides = ''
            [org.gnome.mutter]
            experimental-features = ['scale-monitor-framebuffer']
          '';
          extraGSettingsOverridePackages = [pkgs.gnome.mutter];
        };
      };
    };

    # Desktop software
    flatpak.enable = true;
  };
}
