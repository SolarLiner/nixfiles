{
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      portainer = {
        autoStart = true;
        image = "portainer/portainer-ce:latest";
        ports = ["8080:8000" "9443:9443"];
        volumes = ["/var/run/docker.sock:/var/run/docker.sock" "portainer_data:/data"];
      };
    };
  };
}
