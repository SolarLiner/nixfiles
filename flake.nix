{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";

    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

    # NixOS
    hardware.url = "github:nixos/nixos-hardware";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Nix Darwin
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-borgbackup = {
      url = "github:borgbackup/homebrew-tap";
      flake = false;
    };
    homebrew-bun = {
      url = "github:oven-sh/homebrew-bun";
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
    homebrew-deskflow = {
      url = "github:deskflow/homebrew-tap";
      flake = false;
    };
    gromgit-homebrew-fuse = {
      url = "github:gromgit/homebrew-fuse";
      flake = false;
    };
    homebrew-reactor = {
      # DaVinci Reactor plugin manager
      url = "github:Kartaverse/homebrew-reactor";
      flake = false;
    };

    # Neovim
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    declarative-flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/v4.0.1";
    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    # Nushell
    nu_scripts = {
      url = "github:nushell/nu_scripts";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    determinate,
    nixos-wsl,
    pre-commit-hooks,
    nix-darwin,
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

    # Home Manager, integrated into the NixOS / nix-darwin configurations.
    # `user` is the system user to configure; `modules` are its home-manager modules.
    mkHomeManager = import ./utils/mkHomeConfig.nix;
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
        inherit (self.checks.${system}.pre-commit) shellHook;
        buildInputs =
          self.checks.${system}.pre-commit.enabledPackages
          ++ [nixpkgs.legacyPackages.${system}.just];
      };
    });

    utils = import ./utils;

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
    formatter = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
      config = self.checks.${system}.pre-commit.config;
      inherit (config) package configFile;
      script = ''
        ${pkgs.lib.getExe package} run --all-files --config ${configFile}
      '';
    in
      pkgs.writeShellScriptBin "pre-commit-run" script);

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
      config = system: modules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs outputs;};
          modules =
            [
              nixos-wsl.nixosModules.default
              determinate.nixosModules.default
              home-manager.nixosModules.home-manager
              {
                nixpkgs.overlays = builtins.attrValues outputs.overlays;
                nixpkgs.config.allowUnfree = true;
              }
            ]
            ++ modules;
        };
    in {
      nixos = config "x86_64-linux" [
        ./nixos/hardware/wsl-nixos
        (mkHomeManager {
          inherit inputs outputs;
          user = "nixos";
          modules = [
            ./home-manager/configs/linux.nix
            ./home-manager/users/nixos.nix
            {home.isGraphical = false;}
          ];
        })
      ];
      ovh-vpn-de1 = config "x86_64-linux" [
        ./nixos/hardware/ovh-vpn-de1
      ];
    };

    darwinConfigurations = let
      mkSystem = system: modules:
        nix-darwin.lib.darwinSystem {
          modules =
            [
              ./nix-darwin/configuration.nix
            ]
            ++ modules;
          specialArgs = {
            inherit inputs outputs self system;
            overlays = builtins.attrValues outputs.overlays;
          };
        };
    in rec {
      SolarM3 = mkSystem "aarch64-darwin" [
        ./nix-darwin/users/nathangraule.nix
        {nix.enable = false;}
      ];
      SolarM4 = mkSystem "aarch64-darwin" [
        ./nix-darwin/users/solarliner.nix
        {nix.enable = false;}
      ];
      solarm4 = SolarM4;
    };
  };
}
