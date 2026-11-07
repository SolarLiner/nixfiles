{pkgs, ...}: {
  imports = [
    ../../users/solarliner.nix
    ../cloud-init.nix
    ../qemu-guest.nix
    ./disks.nix
    ./wireguard.nix
  ];
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  environment.systemPackages = with pkgs; [
    inetutils
    mtr
    sysstat
    neovim
  ];

  # hardware.facter.reportPath = ./facter.json;
  services.openssh.enable = true;

  services.cloud-init.config = builtins.readFile ./cloud-init.yaml;

  system.stateVersion = "26.05";
}
