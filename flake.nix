{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # NixOS modules
    musnix.url = github:musnix/musnix;

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in
      import ./pkgs pkgs);
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter =
      forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {
      inherit inputs;
      inherit (nixpkgs) lib;
    };
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = let
      config = system: specific-path:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs outputs;};
          modules = [inputs.musnix.nixosModules.musnix ./nixos/configuration.nix specific-path];
        };
    in {
      precision5520 = config "x86_64-linux" ./nixos/hardware/precision5520;
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = let
      mkConfig = system: specific-path:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit inputs outputs;
            username = "solarliner";
            isWSL = false;
          };
          modules = [
            ./modules/home-manager/google-drive.nix
            ./home-manager/home.nix
            specific-path
          ];
        };
    in {
      "solarliner@precision5520" =
        mkConfig "x86_64-linux" ./home-manager/users/solarliner.nix;
      "nathangraule@SolarMac" =
        mkConfig "x86_64-darwin" ./home-manager/users/nathangraule.nix;
    };
  };
}
