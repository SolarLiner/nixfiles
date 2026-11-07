{
  config,
  pkgs,
  inputs,
  ...
}: {
  age.secrets.vpn-wg-pkey = {
    file = "${inputs.self.outPath}/secrets/ovh-vpn-de1/wireguard";
    # for permission, see man systemd.netdev
    mode = "640";
    owner = "systemd-network";
    group = "systemd-network";
  };

  # Enable NAT
  networking.nat = {
    enable = true;
    enableIPv6 = true;
    externalInterface = "enp3";
    internalInterfaces = ["wg0"];
  };
  networking.useNetworkd = true;

  # From: <https://wiki.nixos.org/wiki/WireGuard#systemd.network>
  systemd.network = {
    enable = true;
    netdevs."50-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
      };
      wireguardConfig = {
        ListenPort = 51820;
        PrivateKeyFile = config.age.secrets.vpn-wg-pkey.path;
        RouteTable = "main";
        FirewallMark = 42;
      };
    };
    networks."50-wg0" = {
      matchConfig.Name = "wg0";
      networkConfig = {
        IPv4Forwarding = true;
        IPv6Forwarding = true;
      };
    };
  };

  systemd.services.wireguard-ui = {
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.wireguard-ui}/bin/wireguard-ui";
      Restart = "on-failure";
      DynamicUser = true;
    };
  };
}
