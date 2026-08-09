{
  inputs,
  config,
  ...
}: let
  inherit (config.system) primaryUser;
in {
  imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];
  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # User owning the Homebrew prefix
    user = primaryUser;

    # Optional: Declarative tap management
    taps = {
      "deskflow/homebrew-tap" = inputs.homebrew-deskflow;
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };

    # Optional: Enable fully-declarative tap management
    #
    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    mutableTaps = false;
    trust = {
      casks = [
        "deskflow/tap/deskflow"
      ];
    };
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    casks = [
      "betterdisplay"
      "deskflow"
      "docker-desktop"
      "ghostty"
      "google-drive"
      "unnaturalscrollwheels"
      "zen"
      "libndi"
    ];
  };
}
