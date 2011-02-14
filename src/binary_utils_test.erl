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

process_message5_test() ->
    put(test1, []),
    Rest = binary_utils:process_message(<<1,0,0,0,5,0>>,
					fun(Message) ->
						put(test1, [Message|get(test1)])
					end),

    ?assertEqual(<<>>, Rest),
    ?assertEqual(2, length(get(test1))),
    [R2,R1] = get(test1),
    ?assertEqual(<<1>>, R1),
    ?assertEqual(<<5>>, R2).

decode_string1_test() ->
    {Str, Rest} = binary_utils:decode_string(<<1,2,0>>),
    ?assertEqual(<<1,2>>, Str),
    ?assertEqual(<<>>, Rest).

decode_string2_test() ->
    {Str1, Rest1} = binary_utils:decode_string(<<1,2,0,4,5,0>>),
    ?assertEqual(<<1,2>>, Str1),
    ?assertEqual(<<4,5,0>>, Rest1),
    {Str2, Rest2} = binary_utils:decode_string(Rest1),
    ?assertEqual(<<4,5>>, Str2),
    ?assertEqual(<<>>, Rest2).

decode_string3_test() ->
    {Str, Rest} = binary_utils:decode_string(<<1,2>>),
    ?assertEqual(<<>>, Str),
    ?assertEqual(<<1,2>>, Rest).

decode_string4_test() ->
    {Str1, Rest1} = binary_utils:decode_string(<<1,2,0,0,1>>),
    ?assertEqual(<<1,2>>, Str1),
    ?assertEqual(<<1>>, Rest1).

decode_string6_test() ->
    {Str1, Rest1} = binary_utils:decode_string(<<1,2,0,0,1,0>>),
    ?assertEqual(<<1,2>>, Str1),
    ?assertEqual(<<1,0>>, Rest1).

decode_string7_test() ->
    {Str1, Rest1} = binary_utils:decode_string(<<1,2,0,0,1,0,0,0,0,2,0,0>>),
    ?assertEqual(<<1,2>>, Str1),
    ?assertEqual(<<1,0,0,0,0,2,0,0>>, Rest1),
    {Str2, Rest2} = binary_utils:decode_string(Rest1),
    ?assertEqual(<<1>>, Str2),
    ?assertEqual(<<2,0,0>>, Rest2),
    {Str3, Rest3} = binary_utils:decode_string(Rest2),
    ?assertEqual(<<2>>, Str3),
    ?assertEqual(<<>>, Rest3).

decode_string8_test() ->
    {Str1, Rest1} = binary_utils:decode_string(<<1,0,0,0,0>>),
    ?assertEqual(<<1>>, Str1),
    ?assertEqual(<<>>, Rest1).

decode_string9_test() ->
    {Str1, Rest1} = binary_utils:decode_string(<<0,0,0,0>>),
    ?assertEqual(<<>>, Str1),
    ?assertEqual(<<>>, Rest1).
