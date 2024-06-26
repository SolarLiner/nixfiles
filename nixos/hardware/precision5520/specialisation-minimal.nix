# vim: ai:et:ts=2:sw=2
{inputs, ...}: {
  specialisation.minimal.inheritParentConfig = false;
  specialisation.minimal.configuration = {
    imports = [
      inputs.hardware.nixosModules.dell-precision-5530
      ./hardware-configuration.nix
      ../../networking.nix
      ../../i18n.nix
    ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.11"; # Did you read the comment?
  };
}
