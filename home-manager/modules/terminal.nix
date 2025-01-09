{
  pkgs,
  config,
  isWSL ? false,
  ...
}: let gl = config.nixGL.wrapper; in {
  programs.zellij = {
    enable = true;
  };
  programs.kitty = {
    enable = !isWSL;
    package = gl pkgs.kitty;
    font = {
      package = pkgs.nerd-fonts;
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
    themeFile = "VSCode_Dark";
  };
}
