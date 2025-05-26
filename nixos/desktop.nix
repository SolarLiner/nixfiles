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
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
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
