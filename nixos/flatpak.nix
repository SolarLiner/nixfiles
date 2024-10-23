{
  config,
  pkgs,
  isServer,
  ...
}: {
  services.flatpak.enable = !isServer;
  xdg.portal.config = {
    common = {
      default = ["kde"];
      "org.freedesktop.impl.portal.Settings" = "kde;gnome";
    };
  };
}
