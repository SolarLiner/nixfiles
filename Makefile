SYSTEM ?= $(shell hostname)
USER ?= $(shell whoami)
FLAKE ?= .
EXTRA_ARGS ?= --log-format internal-json -v -L --keep-failed -j 20 --show-trace
OUTPUT_MONITOR ?= nix run nixpkgs\#nix-output-monitor -- --json

SHELL := nix run nixpkgs\#bash -- -c

ifeq ($(shell uname), Linux)
	SYSTEM_REBUILD := nixos-rebuild
ifeq ($(shell hostname), nixos)
	SYSTEM_REBUILD := $(SYSTEM_REBUILD) --option extra-substituters https://install.determinate.systems --option extra-trusted-public-keys cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM=
endif
else
	SYSTEM_REBUILD := darwin-rebuild
endif

all: system commit

update:
	nix flake update --flake $(FLAKE)

switch:
	$(SYSTEM_REBUILD) build $(EXTRA_ARGS) --flake "$(FLAKE)#$(SYSTEM)" |& $(OUTPUT_MONITOR)

system: build
	sudo $(SYSTEM_REBUILD) switch $(EXTRA_ARGS) --flake "$(FLAKE)#$(SYSTEM)" |& $(OUTPUT_MONITOR)

commit:
	nix develop --command true
	git commit -a


.PHONY: update build switch commit
