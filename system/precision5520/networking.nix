{ ... }:
{
  networking.hostName = "precision5520"; # Define your hostname.

  # Disable networking
  networking.networkmanager.enable = true;

  # Firewall
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  
}
