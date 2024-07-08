{
  pkgs,
  config,
  ...
}: let
  uidOf = username: builtins.toString (config.users.users.${username}.uid);
  gidOf = group: builtins.toString (config.users.groups.${group}.gid);
  user = config.services.jellyfin.user;
  group = config.services.jellyfin.group;
  uid = uidOf user;
  gid = gidOf group;
in {
  environment.systemPackages = [
    pkgs.cifs-utils
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  # SMB mount
  fileSystems."/mnt/nathan1tb" = {
    device = "//192.168.1.254/Nathan 1TB"; # TODO: Figure out why mDNS does not resolve the router hostname
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},uid=${uid},gid=${gid}"];
  };

  # Jellyfin
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
}
