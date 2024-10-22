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
    displayManager = {
      sddm.enable = !isServer;
      sddm.wayland.enable = true;
      defaultSession = "plasma";
    };
    desktopManager.plasma6.enable = !isServer;

    # Desktop software
    flatpak.enable = !isServer;
  };
}
