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
    "reaper"
    "bitwig-studio"
    # "fl-studio" # Disabled on homebrew
    "obsidian"
    "blender"
    "macfuse"
    "mounty"
    "godot-mono"
    "utm"
    "cardinal"
    "vcv-rack"
  ];
  homebrew.masApps = {
    Bitwarden = 1352778147;
  };
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
