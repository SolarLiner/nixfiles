SYSTEM ?= $(shell hostname)
USER ?= $(shell whoami)
FLAKE ?= .
EXTRA_ARGS ?= -j 10

all: system home fmt commit

update:
	nix flake update $(FLAKE)

system: update
	sudo nixos-rebuild switch $(EXTRA_ARGS) --flake $(FLAKE)#$(SYSTEM)

home: update
	home-manager switch $(EXTRA_ARGS) --flake "$(FLAKE)#$(USER)@$(SYSTEM)"

fmt:
	nix fmt

commit: fmt
	git commit -am "system=$(shell nixos-rebuild list-generations | grep current | cut -d' ' -f-4) | home-manager=$(shell home-manager generations | head -n1 | cut -d' ' -f-5)"


.PHONY: update system home fmt commit
