{ inputs, outputs, lib, ... }: {
  imports = [
    inputs.hardware.nixosModules.dell-inspiron-7405
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ./ssh.nix
    ./docker.nix
    ./jupyterhub.nix
    # ./specialisation-minimal.nix
  ];

  networking.hostName = "home-server";
  i18n.defaultLocale = lib.mkForce "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce "fr";
    useXkbConfig = true; # use xkb.options in tty.
  };

  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
    isWSL = true;
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.solarliner = {...}: {
    imports = [
      inputs.plasma-manager.homeManagerModules.plasma-manager
      ../../../modules/home-manager/google-drive.nix
      ../../../home-manager/home.nix
      ../../../home-manager/configs/minimal.nix
      ../../../home-manager/users/solarliner.nix
    ];
  };
}
