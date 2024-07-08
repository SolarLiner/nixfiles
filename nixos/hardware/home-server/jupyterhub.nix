{
  lib,
  pkgs,
  ...
}: {
  services.jupyterhub = {
    enable = true;
    kernels = {
      python3 = let
        env = pkgs.python3.withPackages (p:
          with p; [
            ipykernel
            numpy
            scipy
            sympy
            matplotlib
            pandas
          ]);
      in {
        displayName = "Python 3 (Data science)";
        argv = ["${env.interpreter}" "-m" "ipykernel_launcher" "-f" "{connection_file}"];
        language = "python";
        logo32 = "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
        logo64 = "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
      };
    };
  };
}
