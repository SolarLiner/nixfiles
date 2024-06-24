{pkgs, config, ...}:
let
  uidOf = username: builtins.toString (config.users.users.${username}.uid);
  gidOf = group: builtins.toString (config.users.groups.${group}.gid);
in {
  # SMB mount
  environment.systemPackages = [pkgs.cifs-utils];
  fileSystems."/mnt/nathan1tb" = {
    device = "//freebox-server.local/Nathan 1TB";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in ["${automount_opts},credentials=/etc/nixos/smb-nathan1tb,uid=${uidOf "plex"},gid=${gidOf "plex"}"];
    };

  # Extra firewall rule
  networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';

  # Config
  services.plex = {
    enable = true;
    openFirewall = true;
    user = "plex";
  };
}
