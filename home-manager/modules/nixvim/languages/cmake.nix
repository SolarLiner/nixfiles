{pkgs, ...}: {
  lsp.servers.cmake.enable = true;
  lsp.servers.cmake.package = null;
  plugins.lsp.servers.cmake.enable = true;
  plugins.lsp.servers.cmake.package = null;
  plugins.cmake-tools.enable = true;
}
