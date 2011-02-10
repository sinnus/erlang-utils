-module(test_suite).

-export([test/0]).

test() ->
    eunit:test(binary_utils_test).
