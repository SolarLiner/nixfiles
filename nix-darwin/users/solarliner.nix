{inputs, ...}: {
  users.users.solarliner = {
    name = "Nathan Graule";
    home = "/Users/solarliner";
  };
  system.primaryUser = "solarliner";
  nix-homebrew = {
    taps = {
      "gromgit/homebrew-fuse" = inputs.gromgit-homebrew-fuse;
      "Kartaverse/homebrew-reactor" = inputs.homebrew-reactor;
    };
    trust = {
      formulae = [
        "gromgit/fuse/ntfs-3g-mac"
      ];
      casks = ["kartaverse/reactor/reactor"];
    };
  };
  homebrew = {
    brews = [
      "gromgit/fuse/ntfs-3g-mac"
      "molten-vk"
      "openssl"
      "pkgconf"
    ];
    casks = [
      "audacity"
      "bitwarden"
      "bitwig-studio"
      "blender"
      "cardinal"
      "godot-mono"
      "insta360-studio"
      "kartaverse/reactor/reactor"
      "kopiaui"
      "macfuse"
      "mounty"
      "obsidian"
      "reaper"
      "utm"
      "vcv-rack"
      # "fl-studio" # Disabled on homebrew
    ];
  };
  system.defaults.dock.persistent-apps = [
    "/Applications/Firefox.app"
    "/System/Applications/Mail.app"
    "/Applications/Ghostty.app"
    "/Users/solarliner/Applications/RustRover.app"
    "/Users/solarliner/Applications/PyCharm.app"
    "/Applications/Zed.app"
    "/Applications/REAPER.app"
    "/Applications/Bitwig Studio.app"
    "/System/Applications/Calendar.app"
    "/Applications/Obsidian.app"
    "/System/Applications/System Settings.app"
  ];
}
