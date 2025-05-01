{
  inputs,
  mainUsername,
  ...
}: {
  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = true;

    # User owning the Homebrew prefix
    user = mainUsername;

    # Optional: Declarative tap management
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "alienator88/homebrew-cask" = inputs.alienator88-homebrew-cask;
      "gromgit/homebrew-fuse" = inputs.gromgit-homebrew-fuse;
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
      "betterdisplay"
    ];
  };
}
