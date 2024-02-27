# vim: ai:et:ts=2:sw=2
{inputs, ...}: {
  specialisation.musnix.configuration = {
    imports = [
      inputs.musnix.nixosModules.musnix
    ];

    musnix.enable = true;
  };
}
