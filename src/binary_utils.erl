-module(test).

-export([test/0]).

test() ->
    Rest = process_message(<<1,2,3,0,4,5,0,3,1,2,3,0,0,32>>,
			  fun(Message) ->
				  io:format("Message: ~p~n", [Message])
			  end),
    io:format("Rest: ~p~n", [Rest]).

process_message(Bin, Callback) ->
    {Bin1, Rest} = decode_string(Bin),
    process_message(Bin1, Rest, Callback).

process_message(<<>>, Rest, _Callback) ->
    Rest;

process_message(Bin, Rest, Callback) ->
    Callback(Bin),
    {Bin1, Rest1} = decode_string(Rest),
    process_message(Bin1, Rest1, Callback).

decode_string(Bin) ->
    decode_string(Bin, <<>>).

decode_string(<<0, Rest/binary>>, Acc) ->
    {Acc, Rest};

decode_string(<<>>, Acc) ->
    {<<>>, Acc};

decode_string(<<C, Rest/binary>>, Acc) ->
    decode_string(Rest, <<Acc/binary, C>>).
