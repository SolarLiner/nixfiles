{
  description = "A very basic flake";
  inputs = {
    system-wsl.url = path:./wsl;
  };
  outputs = { system-wsl, ... }: {
    nixosConfigurations = system-wsl.nixosConfigurations;
  };
}
