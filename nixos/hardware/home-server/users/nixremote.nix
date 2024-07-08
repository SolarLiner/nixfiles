{
  users.users.nixremote = {
    name = "nixremote";
    isNormalUser = true;
    group = "nixremote";
    createHome = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGkcGWvM80K0KcUemuvmPHLkYkQN7NPYgtKvW3h9NMV root@precision5520"
    ];
  };
  users.groups.nixremote = {};
}
