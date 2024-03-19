{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    iosevka
    inter
  ];
  programs = {
    kdeconnect = {
      enable = true;
    };
  };
  services = {
    xserver = {
      enable = true;
      displayManager = {
        sddm.enable = true;
        sddm.wayland.enable = true;
        defaultSession = "plasmawayland";
      };
      desktopManager.plasma5.enable = true;
    };

    # Desktop software
    flatpak.enable = true;
  };
}
