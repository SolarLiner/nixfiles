{ config, pkgs, ... }:
let
  gl = config.nixGL.wrapper;
in
{
  programs.zed-editor = {
    enable = true;
    package = gl pkgs.zed-editor;
    userSettings = {
      ui_font_size = 15;
      buffer_font_size = 13;
      buffer_font_family = "Iosevka";
      autosave = "on_focus_change";
      format_on_save = false;
      remove_trailing_whitespace_on_save = true;
      ensure_final_newline_on_save = true;
      theme = "VSCode Dark Modern";
      features.copilot = false;
      vim_mode = true;
      lsp = {
        nil.binary = "${pkgs.nil}/bin/nil";
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
      "vscode-dark-modern"
      "http"
      "nix"
      "wgsl"
      "git-firefly"
    ];
  };
}
