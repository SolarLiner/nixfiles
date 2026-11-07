let
  authorized_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPrvb1L/ac5WVF6Eq6hL1Wqvdm5NRAzUELHbgRlNPdmS me@solarliner.dev"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOpM7a8hHtFIs7LOpoIJGfarO15/sAcU9A8pJqaBjEHj root@nixos"
  ];
in {
  "vpn/wireguard".publicKeys = authorized_keys;
}
