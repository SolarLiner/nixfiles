{pkgs, ...}: {
  users.users.nathangraule = {
    name = "Nathan Graule";
    home = "/Users/nathangraule";
    packages = with pkgs; [
      cmake
      ninja
      tracy_0_9_1
    ];
  };
  homebrew.casks = [
    "thunderbird"
    "skype"
    "bitwig-studio"
    "obsidian"
    #"fl-studio"
  ];
  homebrew.masApps = {
    "Mattermost Desktop" = 1614666244;
    Bitwarden = 1352778147;
    Xcode = 497799835;
  };
  system.defaults.dock.persistent-apps = [
    "/Applications/Firefox.app"
    "/Applications/Thunderbird.app"
    "/Applications/Skype.app"
    "/Applications/Mattermost 5.10.2.app"
    "${pkgs.kitty}/Applications/kitty.app"
    "/Users/nathangraule/Applications/CLion.app"
    "/Users/nathangraule/Applications/PyCharm Professional Edition.app"
    "${pkgs.vscode}/Applications/Visual Studio Code.app"
    "/Applications/FL Studio 2024.app"
    "/Applications/Bitwig Studio.app"
    "/System/Applications/Calendar.app"
    "/Applications/Obsidian.app"
    "/System/Applications/System Settings.app"
  ];
}
