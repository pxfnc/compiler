GHC_VERSION := $(shell ghc --numeric-version)
PLATFORM := aarch64-linux
ELM := $(CURDIR)/dist-newstyle/build/aarch64-osx/ghc-$(GHC_VERSION)/elm-0.19.1/x/elm/build/elm/elm
SAMPLE_PROJ_DIR := "$(CURDIR)/sample_elm_project"

# for Apple Silicon
# PLATFORM := aarch64-osx
# export C_INCLUDE_PATH := $(shell xcrun --show-sdk-path)/usr/include/ffi


.PHONY: default
default: elm debug prod elm-test


.PHONY: elm
elm:
	cabal build -j && cp $(ELM) $(SAMPLE_PROJ_DIR)/node_modules/.bin/elm


.PHONY: clean
clean:
	rm -rf ./dist-newstyle


.PHONY: format
format:
	cd $(SAMPLE_PROJ_DIR) && npx elm-format --yes ./src


.PHONY: debug
debug: format
	cd $(SAMPLE_PROJ_DIR) && rm -rf ./elm-stuff && $(ELM) make --output=$(SAMPLE_PROJ_DIR)/dist/debug.html ./src/Main.elm
	cd $(SAMPLE_PROJ_DIR) && rm -rf ./elm-stuff && $(ELM) make --output=$(SAMPLE_PROJ_DIR)/dist/debug.js   ./src/Main.elm


.PHONY: prod
prod: format
	cd $(SAMPLE_PROJ_DIR) && rm -rf ./elm-stuff && $(ELM) make --optimize --output=$(SAMPLE_PROJ_DIR)/dist/prod.html ./src/Main.elm
	cd $(SAMPLE_PROJ_DIR) && rm -rf ./elm-stuff && $(ELM) make --optimize --output=$(SAMPLE_PROJ_DIR)/dist/prod.js   ./src/Main.elm


.PHONY: elm-test
elm-test: elm
	cd $(SAMPLE_PROJ_DIR) && rm -rf ./elm-stuff && npm test

