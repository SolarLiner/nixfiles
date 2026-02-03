{
  config,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin;
  gl = config.lib.nixGL.wrap;
in {
  programs.zed-editor = {
    enable = true;
    package = gl pkgs.zed-editor;
    userSettings = {
      ui_font_size = 15;
      buffer_font_size = 13;
      buffer_font_family = "Iosevka";
      autosave = "on_focus_change";
      format_on_save = "off";
      remove_trailing_whitespace_on_save = true;
      ensure_final_newline_on_save = true;
      theme = "Catppuccin Mocha";
      icon_theme = "Catppuccin Mocha";
      features.copilot = false;
      vim_mode = true;
      lsp = {
        nil.binary.path = "${pkgs.nil}/bin/nil";
        nil.settings.nix.flake = {
          autoArchive = true;
          autoEvalInputs = true;
        };
      };
    };
    extensions = [
      "live-server"
      "make"
      "slint"
      "sql"
      "http"
      "nix"
      "wgsl"
      "git-firefly"
      "catppuccin"
      "catppuccin-icons"
    ];
  };
}
