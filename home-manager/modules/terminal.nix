{
  config,
  lib,
  pkgs,
  isWSL ? false,
  ...
}:
with lib.lists; {
  programs.zellij = {
    enable = true;
  };
  programs.kitty = {
    enable = !isWSL;
    font = {
      package = pkgs.iosevka;
      name = "Iosevka";
      size =
        if pkgs.stdenv.isDarwin
        then 13
        else 10;
    };
    settings = {
      adjust_line_height = "130%";
      disable_ligatures = "cursor";
      enable_audio_bell = false;
      visual_bell_duration = "0.1";
      window_margin_width = 0;
      tab_bar_style = "powerline";
      shell = "${pkgs.zellij}/bin/zellij";
    };
    shellIntegration = {
      mode = "enabled";
      enableZshIntegration = true;
    };
    theme = "Adwaita dark";
  };
}
