ROGUEC_CPP_FLAGS = -Wall -std=gnu++11 -fno-strict-aliasing -Wno-invalid-offsetof

ifeq ($(OS),Windows_NT)
  ifneq (,$(findstring /cygdrive/,$(PATH)))
      PLATFORM = Cygwin
  else
      PLATFORM = Windows
  endif
else
  UNAME_S := $(shell uname -s)
  ifeq ($(UNAME_S),Darwin)
    PLATFORM = macOS
  else
    PLATFORM = Linux
  endif
endif

BUILD_EXE = .rogo/Build-$(PLATFORM)

all: bootstrap_rogue
	rogo

bootstrap_rogue: $(BUILD_EXE)
	@$(BUILD_EXE) check_bootstrap

bootstrap:
	@echo -------------------------------------------------------------------------------
	@echo "Bootstrapping Rogo Build executable from C++ source..."
	@echo -------------------------------------------------------------------------------
	rm -rf .rogo
	rm -rf Programs/RogueC
	mkdir -p .rogo
	$(CXX) -O3 $(ROGUEC_CPP_FLAGS) Source/RogueC/Bootstrap/Build.cpp -o $(BUILD_EXE)
	$(BUILD_EXE) bootstrap_skip_build_executable

$(BUILD_EXE):
	@echo -------------------------------------------------------------------------------
	@echo "Bootstrapping Rogo Build executable from C++ source..."
	@echo -------------------------------------------------------------------------------
	mkdir -p .rogo
	$(CXX) -O3 $(ROGUEC_CPP_FLAGS) Source/RogueC/Bootstrap/Build.cpp -o $(BUILD_EXE)

-include Local.mk

remake: bootstrap_rogue
	rogo remake


debug: bootstrap_rogue
	rogo debug

exhaustive: bootstrap_rogue
	rogo exhaustive

roguec: bootstrap_rogue
	rogo roguec

update_bootstrap: bootstrap_rogue
	rogo update_bootstrap

rogo: bootstrap_rogue
	rogo rogo

libraries: bootstrap_rogue
	@$(BUILD_EXE) check_bootstrap
	rogo libraries

libs: libraries

x2: bootstrap_rogue
	rogo x 2

x3: bootstrap_rogue
	rogo x 3

revert: bootstrap
	rogo revert

.PHONY: clean
clean: bootstrap_rogue
	rogo clean

uninstall: clean

link: bootstrap_rogue

unlink: bootstrap_rogue
	rogo unlink

docs: bootstrap_rogue
	rogo docs

.PHONY: test
test:
	rogo test

