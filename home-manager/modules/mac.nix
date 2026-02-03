{inputs, ...}: {
  imports = [inputs.mac-app-util.homeManagerModules.default];

  targets.darwin.linkApps.enable = true;
}
