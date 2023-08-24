{
  description = "NixOS configuration for WSL";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    nixos-wsl.url = github:nix-community/nixos-wsl/22.05-5c211b47;
  };
  outputs = { self, nixpkgs, nixos-wsl }: {
    nixosConfigurations = {
      wsl-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          ./configuration.nix
        ];
      };
    };
  };
}
