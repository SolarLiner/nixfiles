{pkgs, ...}: {
  users.users.nathangraule = {
    name = "Nathan Graule";
    home = "/Users/nathangraule";
  };
  system.primaryUser = "nathangraule";
  homebrew.casks = [
    "bitwig-studio"
    "obsidian"
    #"fl-studio"
  ];
  homebrew.masApps = {
    Bitwarden = 1352778147;
    Xcode = 497799835;
  };
  system.defaults.dock.persistent-apps = [
    "/Applications/Zen.app"
    "/System/Applications/Mail.app"
    "/Applications/Microsoft Teams.app"
    "/Applications/Mattermost 5.10.2.app"
    "/Applications/Ghostty.app"
    "/Users/nathangraule/Applications/CLion.app"
    "/Users/nathangraule/Applications/PyCharm.app"
    "/Applications/Nix Apps/Visual Studio Code.app"
    "/Applications/FL Studio 2024.app"
    "/Applications/Bitwig Studio.app"
    "/System/Applications/Calendar.app"
    "/Applications/Obsidian.app"
    "/System/Applications/System Settings.app"
  ];
}
