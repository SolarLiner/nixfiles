{pkgs, ...}: {
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "ipynb.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "ajbucci";
        repo = "ipynb.nvim";
        rev = "9c06504b2597404eceda7da18fd68c0d55edbb4e";
        hash = "sha256-us6+qm5mk6KmB0j8tNiUZeqpKYrtziOl4qrr9aac94c=";
      };
    })
  ];
}
