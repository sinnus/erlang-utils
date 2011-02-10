ERL          ?= erl
EBIN_DIRS    := $(wildcard deps/*/ebin)

all:
	@$(ERL) -pa $(EBIN_DIRS) -noinput +B \
	  -eval 'case make:all() of up_to_date -> halt(0); error -> halt(1) end.'

clean: 
	@echo "removing:"
	@rm -fv ebin/*.beam ebin/*.app

test: all
	$(ERL) -pa ebin/ -eval "test_suite:test()"  -s init stop -noshell
