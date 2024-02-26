{ inputs, ... }: {
  imports = [
    inputs.hardware.nixosModules.dell-precision-5530
    ./hardware-configuration.nix
    ./gpu.nix
  ];

  networking.hostName = "precision5520";
}
