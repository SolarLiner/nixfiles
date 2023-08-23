# vim: expandtab:ai:ts=2:sw=2
{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    homes.url = path:./home;
    systems.url = path:./system;
  };
  outputs = { self, nixpkgs, homes, systems, ... }:
  let system = "x86_64-linux"; in
  {
    inherit (homes) homeConfigurations;
    inherit (systems) nixosConfigurations;
    devShells.${system}.default =
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell;
      in mkShell {
        buildInputs = with pkgs; [home-manager];
      };
  };
}
