{
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = true;
  };
}
