SYSTEM ?= $(shell hostname)
USER ?= $(shell whoami)
FLAKE ?= path:.
EXTRA_ARGS ?= -j 10

all: home system

update:
	nix flake update $(FLAKE)

system: update
	sudo nixos-rebuild switch $(EXTRA_ARGS) --flake $(FLAKE)#$(SYSTEM)

home: update
	home-manager switch $(EXTRA_ARGS) --flake $(FLAKE)#$(USER)

.PHONY: update system home