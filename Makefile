SYSTEM ?= $(shell hostname)
USER ?= $(shell whoami)
FLAKE ?= .
EXTRA_ARGS ?= -L --keep-failed -j 20 --show-trace

ifeq ($(shell uname), Linux)
	SYSTEM_REBUILD := nixos-rebuild
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
