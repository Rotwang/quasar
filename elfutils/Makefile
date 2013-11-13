.PHONY: all regression ut

ifndef V
    MAKEFLAGS += -s
endif

say       := echo
separator := =====
say-sep   := $(say) "$(separator)"

all: regression
regression: ut
ut:
	$(say-sep)
	$(say) "Running UT"
	prove -v -e "perl6 -Ilib"

