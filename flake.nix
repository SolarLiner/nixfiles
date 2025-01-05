{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # NixOS
    hardware.url = "github:nixos/nixos-hardware";

    # Nix Darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    declarative-flatpaks.url = "github:GermanBread/declarative-flatpak/stable-v3";
    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    declarative-flatpaks,
    plasma-manager,
    nix-homebrew,
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
      pkgs = import nixpkgs {
        inherit system;
        overlays = builtins.attrValues outputs.overlays;
      };
    in
      import ./pkgs {inherit pkgs inputs;});

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
      config = system: specific-path: {isServer ? false, ...}:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs outputs isServer;};
          modules = [./nixos/configuration.nix specific-path];
        };
    in {
      #home-server = config "x86_64-linux" ./nixos/hardware/home-server {isServer = true;};
      precision5520 = config "x86_64-linux" ./nixos/hardware/precision5520 {};
    };

    darwinConfigurations = let
      mkSystem = {
        system,
        username,
      }:
        nix-darwin.lib.darwinSystem {
          modules = [
            nix-homebrew.darwinModules.nix-homebrew
            ./nix-darwin/configuration.nix
          ];
          specialArgs = {
            inherit inputs outputs self system username;
            overlays = builtins.attrValues outputs.overlays;
          };
        };
    in {
      "SolarM3" = mkSystem {
        system = "aarch64-darwin";
        username = "nathangraule";
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = let
      mkConfig = system: specific-path:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = builtins.attrValues outputs.overlays;
          };
          extraSpecialArgs = {
            inherit inputs outputs;
            username = "solarliner";
            isWSL = false;
          };
          modules = [
            declarative-flatpaks.homeManagerModules.default
            plasma-manager.homeManagerModules.plasma-manager
            ./modules/home-manager/google-drive.nix
            ./home-manager/home.nix
            specific-path
          ];
        };
    in {
      "solarliner@precision5520" =
        mkConfig "x86_64-linux" ./home-manager/users/solarliner.nix;
      "nathangraule@SolarM3" =
        mkConfig "aarch64-darwin" ./home-manager/users/nathangraule.nix;
    };
  };
}
