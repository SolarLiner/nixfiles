{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.lldb.dave;
  enable = config.programs.lldb.enable && cfg.enable;
  py = cfg.python;
  pyPkgs = py.pkgs;
  davext = pyPkgs.buildPythonPackage rec {
    pname = "davext";
    version = "0.14.0";
    src = pkgs.fetchFromGitHub {
      owner = "maxmarsc";
      repo = "dave";
      rev = "v${version}";
      hash = "sha256-ACVf7JJxXCDZkWTaBWsNNY2UGXwY/QXSo3Yuh5SWw7w=";
    };
  };
in {
  options.programs.lldb.dave = {
    enable = mkEnableOption "dave";
    python = mkPackageOption pkgs "python310" {};
  };
  config = mkIf enable {
    programs.lldb.initContent = ''
      command script import ~/.dave/lldb_init.py
    '';
    home.file.".dave/lldb_init.py".source = "${davext.src}/dave/assets/lldb_init.py";
    home.file.".dave/venv/bin/activate".text = let
      venv = py.withPackages (_: [davext]);
    in ''
      export PATH=${venv}/bin:$PATH
      if [ -n "${PYTHONHOME:-}" ] ; then
        unset PYTHONHOME
      fi
      hash -r 2> /dev/null
    '';
  };
}
