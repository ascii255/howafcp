STEM    := hello_world
PORT    := 8080
EMFLAGS := -O3  # default = release

# ── detect available JS runtime ──────────────────────────────
NODE    := $(shell which node 2>/dev/null || which nodejs 2>/dev/null || which d8 2>/dev/null)

# ────────────────────────────────────────────────────────────
# Default target
# ────────────────────────────────────────────────────────────
.PHONY: all
all:
	$(MAKE) EMFLAGS="-O3" $(STEM).html

# ────────────────────────────────────────────────────────────
# Mode targets
# ────────────────────────────────────────────────────────────
.PHONY: release debug

release:
	$(MAKE) EMFLAGS="-O3" $(filter-out $@, $(MAKECMDGOALS))

debug:
	$(MAKE) EMFLAGS="-g -sASSERTIONS -sSAFE_HEAP" $(filter-out $@, $(MAKECMDGOALS))

# ────────────────────────────────────────────────────────────
# Swallow other targets in the top-level mode-dispatch call
# ────────────────────────────────────────────────────────────
ifeq ($(filter release debug, $(MAKECMDGOALS)),)

# ── Sentinel: rebuild whenever EMFLAGS changes ───────────────
SENTINEL := .emflags.sentinel
ifneq ($(shell cat $(SENTINEL) 2>/dev/null),$(EMFLAGS))
$(shell echo '$(EMFLAGS)' > $(SENTINEL))
endif

.PHONY: js html serve run

js: $(STEM).js

html: $(STEM).html

run: $(STEM).js
	$(NODE) $<

serve: $(STEM).html
	emrun --no_browser --port $(PORT) .

$(STEM).js: $(STEM).cpp $(SENTINEL)
	emcc $< $(EMFLAGS) -o $@

$(STEM).html: $(STEM).cpp $(SENTINEL)
	emcc $< --emrun $(EMFLAGS) -o $@

else

%:
	@true

endif

# ────────────────────────────────────────────────────────────
# Utility
# ────────────────────────────────────────────────────────────
.PHONY: clean

clean:
	rm -f $(STEM).js $(STEM).wasm $(STEM).html $(SENTINEL)
