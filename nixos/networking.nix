{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.networkmanager.enable = true;
  networking.networkmanager.logLevel = "DEBUG";

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
  };
}
