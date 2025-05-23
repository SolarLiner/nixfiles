{pkgs, ...}: {
  users.users.nathangraule = {
    name = "Nathan Graule";
    home = "/Users/solarliner";
    packages = with pkgs; [
      cmake
      ninja
      tracy
    ];
  };
  homebrew.brews = [
    "gromgit/fuse/ntfs-3g-mac"
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
  ];
  homebrew.masApps = {
    Bitwarden = 1352778147;
    Xcode = 497799835;
  };
  system.defaults.dock.persistent-apps = [
    "/Applications/Zen.app"
    "/System/Applications/Mail.app"
    "/Applications/Ghostty.app"
    "/Users/solarliner/Applications/RustRover.app"
    "/Users/solarliner/Applications/PyCharm.app"
    "${pkgs.vscode}/Applications/Visual Studio Code.app"
    "/Applications/REAPER.app"
    "/Applications/Bitwig Studio.app"
    "/System/Applications/Calendar.app"
    "/Applications/Obsidian.app"
    "/System/Applications/System Settings.app"
  ];
}
