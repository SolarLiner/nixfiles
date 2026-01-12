{pkgs, ...}: {
  users.users.solarliner = {
    name = "Nathan Graule";
    home = "/Users/solarliner";
    packages = with pkgs; [
      tracy
    ];
  };
  system.primaryUser = "solarliner";
  homebrew.brews = [
    "gromgit/fuse/ntfs-3g-mac"
    "pkgconf"
    "openssl"
  ];
  homebrew.casks = [
    "audacity"
    "bitwarden"
    "bitwig-studio"
    "blender"
    "cardinal"
    "godot-mono"
    "macfuse"
    "mounty"
    "obsidian"
    "reaper"
    "utm"
    "vcv-rack"
    "kopiaui"
    # "fl-studio" # Disabled on homebrew
  ];
  system.defaults.dock.persistent-apps = [
    "/Applications/Zen.app"
    "/System/Applications/Mail.app"
    "/Applications/Ghostty.app"
    "/Users/solarliner/Applications/RustRover.app"
    "/Users/solarliner/Applications/PyCharm.app"
    "/Applications/Nix Apps/Visual Studio Code.app"
    "/Applications/REAPER.app"
    "/Applications/Bitwig Studio.app"
    "/System/Applications/Calendar.app"
    "/Applications/Obsidian.app"
    "/System/Applications/System Settings.app"
  ];
}
