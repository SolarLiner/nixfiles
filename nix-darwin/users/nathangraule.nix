{
  inputs,
  outputs,
  ...
}: let
  mkHomeConfig = import ../../utils/mkHomeConfig.nix;
in {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    (mkHomeConfig {
      inherit inputs outputs;
      user = "nathangraule";
      modules = [
        ../../home-manager/users/nathangraule.nix
      ];
    })
  ];

  users.users.nathangraule = {
    name = "nathangraule";
    description = "Nathan Graule";
    home = "/Users/nathangraule";
  };
  system.primaryUser = "nathangraule";
  homebrew = {
    brews = ["tracy"];
    casks = [
      "bitwig-studio"
      "obsidian"
      "bitwarden"
    ];
  };
  system.defaults.dock.persistent-apps = [
    "/Applications/Firefox.app"
    "/Applications/Google Chrome.app"
    "/System/Applications/Mail.app"
    "/Applications/Ghostty.app"
    "/Users/nathangraule/Applications/CLion.app"
    "/Users/nathangraule/Applications/PyCharm.app"
    "/Applications/Zed.app"
    "/Applications/FL Studio 2024.app"
    "/Applications/Bitwig Studio.app"
    "/System/Applications/Calendar.app"
    "/Applications/Obsidian.app"
    "/System/Applications/System Settings.app"
  ];
}
