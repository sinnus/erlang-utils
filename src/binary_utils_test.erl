-module(binary_utils_test).

-include_lib("eunit/include/eunit.hrl").

process_message1_test() ->
    put(test1, []),
    Rest = binary_utils:process_message(<<1,2,3,0,4,5,0,3,1,2,3,0,0,32>>,
					fun(Message) ->
						put(test1, [Message|get(test1)])

					end),
    ?assertEqual(<<32>>, Rest),
    [R3, R2, R1] = get(test1),
    ?assertEqual(<<1,2,3>>, R1),
    ?assertEqual(<<4,5>>, R2),
    ?assertEqual(<<3,1,2,3>>, R3).

process_message2_test() ->
    put(test1, []),
    Rest = binary_utils:process_message(<<>>,
					fun(Message) ->
						put(test1, [Message|get(test1)])
					end),
    [] = get(test1),
    ?assertEqual(<<>>, Rest).

process_message3_test() ->
    put(test1, []),
    Rest = binary_utils:process_message(<<1,3>>,
					fun(Message) ->
						put(test1, [Message|get(test1)])
					end),
    [] = get(test1),
    ?assertEqual(<<1,3>>, Rest).

process_message4_test() ->
    put(test1, []),
    Rest = binary_utils:process_message(<<1,0,5,32,0>>,
					fun(Message) ->
						put(test1, [Message|get(test1)])
					end),
    [R2,R1] = get(test1),
    ?assertEqual(<<1>>, R1),
    ?assertEqual(<<5,32>>, R2),
    ?assertEqual(<<>>, Rest).

%% process_message5_test() ->
%%     put(test1, []),
%%     Rest = binary_utils:process_message(<<1,0,0,0,5,0>>,
%% 					fun(Message) ->
%% 						put(test1, [Message|get(test1)])
%% 					end),

%%     ?assertEqual(<<>>, Rest),
%%     ?assertEqual(2, length(get(test1))),
%%     [R2,R1] = get(test1),
%%     ?assertEqual(<<1>>, R1).
