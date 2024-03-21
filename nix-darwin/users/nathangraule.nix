{pkgs, ...}: {
  users.users.nathangraule = {
    name = "Nathan Graule";
    home = "/Users/nathangraule";
    packages = with pkgs; [
      cmake
      ninja
      tracy_0_9_1
    ];
  };
}
