{
  pkgs,
  isServer,
  outputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    iosevka
    jetbrains-mono
    inter
    nerd-fonts
  ];
  programs = {
    kdeconnect = {
      enable = true;
    };
  };
  services = {
    xserver = {
      enable = !isServer;
      displayManager = {
        sddm.enable = !isServer;
        sddm.wayland.enable = true;
        defaultSession = "plasmawayland";
      };
      desktopManager.plasma5.enable = !isServer;
    };

    # Desktop software
    flatpak.enable = !isServer;
  };
}
