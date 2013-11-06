.PHONY: all regression ut sct

ifndef V
    MAKEFLAGS += -s
    to-dev-null := >/dev/null 2>&1
endif

sut := ./revdep6.pl
say := echo
separator := =====
say-sep := $(say) "$(separator)"
run-sct = $(say) -n "$2 ... "; $1; retval="$$?"; if [[ $$retval $3 0 ]]; then echo ok; else $(say) nok "(>>>$1<<< retval: $$retval)"; fi
run-sct-ok  = $(call run-sct,$1,$2,-eq)
run-sct-nok = $(call run-sct,$1,$2,-ne)

all: regression
regression: ut sct
ut:
	$(say-sep)
	$(say) "Running UT"
	prove -v -e "perl6 -Ilib"

sct:
	$(say-sep)
	$(say) "Running SCT"
	$(call run-sct-nok,$(sut) $(to-dev-null),fail if argument not supplied)
	$(call run-sct-nok,$(sut) ./does_not_exist $(to-dev-null),fail if non-existing file supplied as argument)
	$(call run-sct-ok,$(sut) $$(which perl6) $(to-dev-null),do not fail if existing file supplied as argument)
	$(call run-sct-nok,PATH= $(sut) $$(which perl6) $(to-dev-null),fail if readelf not in path)
