{inputs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    inputs.hardware.nixosModules.dell-precision-5530
    ./hardware-configuration.nix
    ./gpu.nix
  ];

  networking.hostName = "precision5520";
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
}
