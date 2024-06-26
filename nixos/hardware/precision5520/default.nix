{inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.dell-precision-5530
    ./hardware-configuration.nix
    ./gpu.nix
    # ./specialisation-minimal.nix
  ];

  musnix.soundcardPciId = "0:1f.3";

  networking.hostName = "precision5520";
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
}
