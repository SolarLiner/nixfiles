{
  config,
  pkgs,
  ...
}: let
  inherit (pkgs) stdenv;
in {
  services.flatpak = {
    enableModule = !stdenv.isDarwin;
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };
    packages = [
      "flathub:app/com.github.tchx84.Flatseal//stable"
      "flathub:app/org.gnome.DejaDup//stable"
      "flathub:app/org.gnome.seahorse.Application//stable"
      "flathub:app/com.bitwarden.desktop//stable"
      "flathub:app/org.mozilla.firefox//stable"
      "flathub:app/net.nokyan.Resources//stable"
      "flathub:app/com.usebottles.bottles//stable"
      "flathub:app/org.mozilla.Thunderbird//stable"
      "flathub:app/com.belmoussaoui.Decoder//stable"
      "flathub:app/com.valvesoftware.Steam//stable"
      "flathub:app/com.valvesoftware.SteamLink//stable"
      "flathub:app/org.gimp.GIMP//stable"
      "flathub:app/org.kde.krita//stable"
      "flathub:app/org.inkscape.Inkscape//stable"
      "flathub:app/com.bitwig.BitwigStudio//stable"
      "flathub:app/fm.reaper.Reaper//stable"
      "flathub:app/org.freedesktop.LinuxAudio.Plugins.DISTRHO-Ports//stable"
      "flathub:app/org.freedesktop.LinuxAudio.Plugins.jc303//stable"
      "flathub:app/org.freedesktop.LinuxAudio.Plugins.LSP//stable"
      "flathub:app/org.freedesktop.LinuxAudio.Plugins.Cardinal//stable"
      "flathub:app/org.freedesktop.LinuxAudio.Plugins.Geonkick//stable"
      "flathub:app/org.freedesktop.LinuxAudio.Plugins.Ratatouille//stable"
      "flathub:app/org.freedesktop.LinuxAudio.Plugins.Airwindows//stable"
      "flathub:app/org.freedesktop.LinuxAudio.Plugins.ChowTapeModel//stable"
      "flathub:app/org.freedesktop.LinuxAudio.Plugins.VL1Emulator//stable"
      "flathub:app/org.freedesktop.LinuxAudio.Plugins.Surge//stable"
      "flathub:app/org.freedesktop.LinuxAudio.Plugins.DPF-Plugins//stable"
      "flathub:app/org.freedesktop.LinuxAudio.Plugins.DragonflyReverb//stable"
    ];
    overrides = let
      electron = {
        environment = {
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
        };
      };
      x11 = {
        sockets = ["x11" "fallback-x11" "wayland"];
      };
    in {
      "global" = {
        filesystems = [
          "/usr/share/fonts/:ro"
          "/usr/share/icons/:ro"
          "${config.home.homeDirectory}/.local/share/fonts:ro"
          "${config.home.homeDirectory}/.local/share/icons:ro"
          "/nix/store:ro"
          "home"
        ];
        sockets = [
          "!x11"
          "!fallback-x11"
        ];
        environment = {
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
        };
      };
      "org.mozilla.Firefox" = {
        environment = {
          "MOZ_ENABLE_WAYLAND" = 1;
        };
      };
      "fm.reaper.Reaper" = x11;
      "com.bitwig.BitwigStudio" = x11;
    };
  };
  systemd.user.mounts = let
    mkMount = name: path: pathsToLink: {
      Unit = {
        Description = "Bind-mount ${name} for user flatpaks";
      };
      Mount = {
        What = pkgs.buildEnv {
          name = "home-${name}";
          paths = config.home.packages;
          inherit pathsToLink;
        };
        Where = config.home.homeDirectory + "/${path}";
      };
    };
  in {
    flatpak-icons = mkMount "icons" ".local/share/icons" ["/share/icons"];
    flatpak-fonts = mkMount "fonts" ".local/share/fonts" ["/share/fonts"];
  };
}
