{
  description = "flake for precision5520";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = github:nixos/nixos-hardware;
  };

  outputs = { self, nixpkgs, nixos-hardware }@inputs: {
    nixosConfigurations = rec {
      nixos = precision5520;
      precision5520 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          nixos-hardware.nixosModules.common-gpu-nvidia
          nixos-hardware.nixosModules.dell-precision-5530
          ./hardware-configuration.nix
          ./boot.nix
          ./configuration.nix
          ./desktop-environment.nix
          ./disks.nix
          ./gpu.nix
          ./networking.nix
          ./system-time.nix
          ./user-solarliner.nix
          ./specialisation-minimal.nix
          ./sensitive
        ];
      };
    };
  };
}
