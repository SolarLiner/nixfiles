set shell := ["bash", "-euo", "pipefail", "-c"]

system := env("SYSTEM", `hostname -s`)
flake := env("FLAKE", justfile_directory())
extra_args := env("EXTRA_ARGS", "--log-format internal-json -v -L --keep-failed -j 20 --show-trace")
output_monitor := env("OUTPUT_MONITOR", "nix run nixpkgs#nix-output-monitor -- --json")

determinate_cache := "--option extra-substituters https://install.determinate.systems --option extra-trusted-public-keys cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
rebuild_bin := if os() == "macos" { "darwin-rebuild" } else { "nixos-rebuild" }
rebuild_opts := if os() == "linux" { if system == "nixos" { determinate_cache } else { "" } } else { "" }

# Build and activate the system configuration, then commit
default: switch commit

# Update flake inputs
update:
    nix flake update --flake "{{ flake }}"

# Build the system configuration without activating it
build:
    {{ rebuild_bin }} build {{ rebuild_opts }} {{ extra_args }} --flake "{{ flake }}#{{ system }}" 2>&1 | {{ output_monitor }}

# Build and activate the system configuration (includes home-manager)
switch: build
    sudo "$(command -v {{ rebuild_bin }})" switch {{ rebuild_opts }} {{ extra_args }} --flake "{{ flake }}#{{ system }}" 2>&1 | {{ output_monitor }}

# Install pre-commit hooks and commit all changes
commit:
    nix develop "{{ flake }}" --command true
    git -C "{{ flake }}" commit -a
