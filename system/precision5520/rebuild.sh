subcommand=${1:-switch}

curdir=$(dirname "$(realpath $0)")

sudo nixos-rebuild --flake "path:${curdir}" "${subcommand}"
