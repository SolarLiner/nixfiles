SYSTEM ?= $(shell hostname)
USER ?= $(shell whoami)
FLAKE ?= .
EXTRA_ARGS ?= -L --keep-failed -j 20 --show-trace

ifeq ($(shell uname), Linux)
	SYSTEM_REBUILD := nixos-rebuild
ifeq ($(shell hostname), nixos)
	SYSTEM_REBUILD := $(SYSTEM_REBUILD) --option extra-substituters https://install.determinate.systems --option extra-trusted-public-keys cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM=
endif
else
	SYSTEM_REBUILD := darwin-rebuild
endif

all: system home commit

update:
	nix flake update --flake $(FLAKE)

system:
	$(SYSTEM_REBUILD) build $(EXTRA_ARGS) --flake "$(FLAKE)#$(SYSTEM)"
	sudo $(SYSTEM_REBUILD) switch $(EXTRA_ARGS) --flake "$(FLAKE)#$(SYSTEM)"

home:
	home-manager switch $(EXTRA_ARGS) --flake "$(FLAKE)#$(USER)@$(SYSTEM)"

commit:
	git commit -a


.PHONY: home-init update system home fmt commit
