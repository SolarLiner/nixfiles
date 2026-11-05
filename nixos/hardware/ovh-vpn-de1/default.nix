{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ../../users/solarliner.nix
    ../vpn-disks.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  hardware.facter.reportPath = ./facter.json;
  services.openssh.enable = true;
  system.stateVersion = "26.05";
}
