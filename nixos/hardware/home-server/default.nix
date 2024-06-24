{ inputs, outputs, lib, ... }: {
  imports = [
    inputs.hardware.nixosModules.dell-inspiron-7405
    inputs.home-manager.nixosModules.home-manager
    ./users
    ./hardware-configuration.nix
    ./ssh.nix
    ./docker.nix
    ./jellyfin.nix
    ./jupyterhub.nix
    ./postgres.nix
    # ./specialisation-minimal.nix
  ];

  networking.hostName = "home-server";
  networking.firewall = {
    interfaces = {
      "enp0s20f0u1".allowedTCPPorts = [ 21 22 80 443 5353 8000 8080 9443 ];
    };
  };
  
  services.resolved = {
    enable = true;
    fallbackDns = [
      "192.168.1.254"
      "8.8.8.8"
      "1.1.1.1"
    ];
  };

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
