# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  environmentd = import ./environmentd.nix;
  google-drive = import ./google-drive.nix;
  nixgl = import ./nixgl.nix;
}
