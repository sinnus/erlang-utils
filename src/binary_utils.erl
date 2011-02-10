-module(binary_utils).

-export([process_message/2,
	 decode_string/2]).

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
