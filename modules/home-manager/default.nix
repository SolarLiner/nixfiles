# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  customization = ./customization.nix;
  dave = ./dave.nix;
  environmentd = ./environmentd.nix;
  google-drive = ./google-drive.nix;
  lldb = ./lldb.nix;
  lldbinit = ./lldbinit.nix;
  nixgl = ./nixgl.nix;
}
