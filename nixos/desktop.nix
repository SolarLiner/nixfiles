{
  pkgs,
  isServer,
  outputs,
  ...
}: {
  environment.systemPackages = with pkgs; [firefox];
  fonts.enableDefaultPackages = true;
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    iosevka
    jetbrains-mono
    inter
    nerd-fonts
  ];
  programs.kdeconnect.enable = true;
  services = {
    displayManager = {
      sddm.enable = !isServer;
      sddm.wayland.enable = true;
      defaultSession = "plasma";
    };
    desktopManager.plasma6.enable = !isServer;
  };
}
