SYSTEM ?= $(shell hostname)
USER ?= $(shell whoami)
FLAKE ?= .
EXTRA_ARGS ?= -j 10

ifeq ($(shell uname), Linux)
	SYSTEM_REBUILD := nixos-rebuild
	SYSTEM_CURGEN := $(SYSTEM_REBUILD) list-generations 2> /dev/null | grep current | cut -d' ' -f-4 | tr -cs '[:alnum:]' ' '
else
	SYSTEM_REBUILD := darwin-rebuild
	SYSTEM_CURGEN := $(SYSTEM_REBUILD) --list-generations | grep current | cut -w -f-3 | tr -cs '[:alnum:]' ' '
endif
HOME_MANAGER_CURGEN := home-manager generations 2> /dev/null | head -n1 | cut -d' ' -f-5

all: system home fmt commit

update:
	nix flake update $(FLAKE)

system:
	$(SYSTEM_REBUILD) build $(EXTRA_ARGS) --flake $(FLAKE)#$(SYSTEM)
	sudo $(SYSTEM_REBUILD) switch $(EXTRA_ARGS) --flake $(FLAKE)#$(SYSTEM)

home:
	home-manager switch $(EXTRA_ARGS) --flake "$(FLAKE)#$(USER)@$(SYSTEM)"

fmt:
	nix fmt

commit: fmt
	git commit -am"system=$(shell $(SYSTEM_CURGEN)) | home-manager=$(shell $(HOME_MANAGER_CURGEN))"


.PHONY: update system home fmt commit
