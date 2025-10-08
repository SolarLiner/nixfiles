{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

    # NixOS
    hardware.url = "github:nixos/nixos-hardware";

    # Nix Darwin
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";
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
    alienator88-homebrew-cask = {
      url = "github:alienator88/homebrew-cask";
      flake = false;
    };
    gromgit-homebrew-fuse = {
      url = "github:gromgit/homebrew-fuse";
      flake = false;
    };

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    declarative-flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/v4.0.1";
    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
    nixgl.url = "github:nix-community/nixGL";

    # Secrets
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = {
    self,
    nixpkgs,
    pre-commit-hooks,
    nix-darwin,
    home-manager,
    declarative-flatpaks,
    plasma-manager,
    nix-homebrew,
    nixgl,
    mac-app-util,
    sops-nix,
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
    checks = forAllSystems (system: {
      pre-commit = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
          stylua.enable = true;
          shellcheck.enable = true;
        };
      };
    });

    devShells = forAllSystems (system: {
      default = nixpkgs.legacyPackages.${system}.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
      };
    });

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
          overlays = builtins.attrValues import outputs.overlays;
          specialArgs = {inherit inputs outputs isServer;};
          modules = [
            sops-nix.nixosModules.sops
            ./nixos/configuration.nix
            specific-path
          ];
        };
    in {
      #home-server = config "x86_64-linux" ./nixos/hardware/home-server {isServer = true;};
      precision5520 = config "x86_64-linux" ./nixos/hardware/precision5520 {};
    };

    darwinConfigurations = let
      mkSystem = {
        system,
        userConfiguration,
        useDeterminateNix ? false,
      }:
        nix-darwin.lib.darwinSystem {
          modules = [
            ./nix-darwin/configuration.nix
            userConfiguration
            {nix.enable = !useDeterminateNix;}
          ];
          specialArgs = {
            inherit inputs outputs self system;
            overlays = builtins.attrValues outputs.overlays;
          };
        };
    in {
      "SolarM3" = mkSystem {
        system = "aarch64-darwin";
        userConfiguration = ./nix-darwin/users/nathangraule.nix;
      };
      SolarM4.local = mkSystem {
        system = "aarch64-darwin";
        userConfiguration = ./nix-darwin/users/solarliner.nix;
        useDeterminateNix = true;
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = let
      mkConfig = system: module:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = builtins.attrValues outputs.overlays;
          };
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./home-manager/home.nix
            module
          ];
        };
    in {
      "solarliner@homepc" =
        mkConfig "x86_64-linux" {imports = [./home-manager/configs/linux.nix ./home-manager/users/solarliner.nix];};
      "nathangraule@SolarM3" =
        mkConfig "aarch64-darwin" {imports = [./home-manager/configs/mac.nix ./home-manager/users/nathangraule.nix { home.isGraphical = true; }];};
      "solarliner@SolarM4.local" =
        mkConfig "aarch64-darwin" {imports = [./home-manager/configs/mac.nix ./home-manager/users/solarliner.nix { home.isGraphical = true; }];};
    };
  };
}
