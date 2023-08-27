{ pkgs, ... }:
let
  ocenaudio = pkgs.ocenaudio.overrideAttrs (_: _: rec {
    version = "3.12.5";
    src = builtins.fetchurl {
      url = "https://www.ocenaudio.com/downloads/index.php/ocenaudio_debian9_64.deb?version=${version}";
      sha256 = "sha256:10qcyhk5s1b0909agp7rn7z75xn6p9ayqkr3ln34if5hsk0nrrzr";
    };
  });
  vcv-rack = pkgs.vcv-rack.overrideAttrs (_: _: rec {
    version = "2.4.0";
    src = pkgs.fetchFromGitHub {
      owner = "VCVRack";
      repo = "Rack";
      rev = "v${version}";
      sha256 = "sZTHMWMeE5J22/OmWkEMSMGW+pHsrN7SrJJoVbrH+Ss=";
    };
  });
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.solarliner = {
    isNormalUser = true;
    createHome = true;
    description = "Nathan Graule";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
    packages = with pkgs; [
      # Basic
      home-manager
      firefox
      thunderbird
      # Wine
      wineWowPackages.waylandFull
      winetricks
      # Programming
      kate
      vscode-fhs
      jetbrains.idea-ultimate
      jetbrains.clion
      # EE
      kicad
      # Audio
      yabridge
      yabridgectl
      ocenaudio
      carla
      cardinal
      distrho
      vcv-rack
      bitwig-studio
      reaper
    ];
  };
}
