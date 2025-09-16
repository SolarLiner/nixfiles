{pkgs, inputs, config, ...}: {
  imports = [inputs.plasma-manager.homeModules.plasma-manager];
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    inter
  ];
  programs.plasma = {
    input.keyboard = {
      layouts = [
        { layout = "fr"; variant = "mac"; }
      ];
      model = "applealu_ansi";
    };
    workspace = {
      cursor = {
        size = 24;
        theme = "volantes_cursors";
      };
      iconTheme = "Breeze-dark";
      wallpaper = let inherit (config.home) homeDirectory; in "${homeDirectory}/wallpaper.png";
      windowDecorations.theme = "WhiteSur-dark";
    };
  };
}
