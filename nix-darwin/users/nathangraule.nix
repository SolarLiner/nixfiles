{pkgs, ...}: {
  users.users.nathangraule = {
    name = "Nathan Graule";
    home = "/Users/nathangraule";
  };
  system.primaryUser = "nathangraule";
  homebrew.casks = [
    "bitwig-studio"
    "obsidian"
    "bitwarden"
    "zed"
    #"fl-studio"
  ];
  system.defaults.dock.persistent-apps = [
    "/Applications/Zen.app"
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
