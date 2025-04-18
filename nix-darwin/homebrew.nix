{
  inputs,
  mainUsername,
  ...
}: let
  inherit (inputs) homebrew-core homebrew-bundle homebrew-cask alienator88-homebrew-cask;
in {
  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = true;

    # User owning the Homebrew prefix
    user = mainUsername;

    # Optional: Declarative tap management
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-bundle" = homebrew-bundle;
      "homebrew/homebrew-cask" = homebrew-cask;
      "alienator88/homebrew-cask" = alienator88-homebrew-cask;
    };

    # Optional: Enable fully-declarative tap management
    #
    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    mutableTaps = false;
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    casks = [
      "firefox"
      "unnaturalscrollwheels"
      "ghostty"
      "alienator88/homebrew-cask/sentinel-app"
    ];
  };
}
