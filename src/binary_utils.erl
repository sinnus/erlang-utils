-module(binary_utils).

-export([process_message/2,
	 decode_string/1]).

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
    decode_string(Bin, <<>>, false).

decode_string(<<0, Rest/binary>>, Acc, _WasZero) ->
    decode_string(Rest, Acc, true);

decode_string(<<>>, Acc, true) ->
    {Acc, <<>>};

decode_string(<<>>, Acc, false) ->
    {<<>>, Acc};

decode_string(Rest, Acc, true) ->
    {Acc, Rest};

decode_string(<<C, Rest/binary>>, Acc, false) ->
    decode_string(Rest, <<Acc/binary, C>>, false).
