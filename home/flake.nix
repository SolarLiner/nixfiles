{
  description = "A very basic flake";

  inputs = {
    home-solarliner.url = path:./solarliner;
  };

  outputs = { home-solarliner, ... }: 
  let system = "x86_64-linux"; in {
    homeConfigurations = rec {
      inherit (home-solarliner.packages.${system}.homeConfigurations) solarliner nixos;
    };
  };
}
