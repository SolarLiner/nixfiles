{
  config,
  inputs,
  outputs,
  self,
  pkgs,
  system,
  ...
}: {
  imports = [
    inputs.mac-app-util.darwinModules.default
    inputs.determinate.darwinModules.default
    ./determinate.nix
    ./i18n.nix
    ./homebrew.nix
    ./system-settings.nix
  ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    just
    mkalias
    qalculate-qt
    kitty
  ];

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Allow Touch ID to authenticate sudo (written to /etc/pam.d/sudo_local).
  security.pam.services.sudo_local.touchIdAuth = true;
  # Make Touch ID work inside tmux/screen sessions.
  security.pam.services.sudo_local.reattach = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 7;
  ids.gids.nixbld = 30000;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = system;
  nixpkgs.overlays = builtins.attrValues outputs.overlays;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["nix-2.16.2"];
}
