-module(marina_request).
-include("marina.hrl").

-export([
    execute/6,
    prepare/3,
    query/5,
    startup/1
]).

%% public
-spec execute(stream(), [frame_flag()], statement_id(), [binary()], consistency(), [flag()]) ->
    binary().

execute(Stream, FrameFlags, StatementId, Values, ConsistencyLevel, Flags) ->
    ValuesCount = length(Values),
    EncodedValues = [marina_types:encode_bytes(Value) || Value <- Values],
    Flags2 = flags([{values, true} | Flags]),

    marina_frame:encode(#frame {
        stream = Stream,
        opcode = ?OP_EXECUTE,
        flags = frame_flags(FrameFlags),
        body = <<(marina_types:encode_short_bytes(StatementId))/binary,
            (marina_types:encode_short(ConsistencyLevel))/binary,
            Flags2,
            (marina_types:encode_short(ValuesCount))/binary,
            (iolist_to_binary(EncodedValues))/binary>>
    }).

-spec prepare(stream(), [frame_flag()], query()) -> binary().

prepare(Stream, FrameFlags, Query) ->
    marina_frame:encode(#frame {
        stream = Stream,
        opcode = ?OP_PREPARE,
        flags = frame_flags(FrameFlags),
        body = <<(marina_types:encode_long_string(Query))/binary>>
    }).

-spec query(stream(), [frame_flag()], query(), consistency(), [flag()]) -> binary().

query(Stream, FrameFlags, Query, ConsistencyLevel, Flags) ->
    Flags2 = flags(Flags),
    marina_frame:encode(#frame {
        stream = Stream,
        opcode = ?OP_QUERY,
        flags = frame_flags(FrameFlags),
        body = <<(marina_types:encode_long_string(Query))/binary,
            (marina_types:encode_short(ConsistencyLevel))/binary, Flags2>>
    }).

-spec startup([frame_flag()]) -> binary().

startup(FrameFlags) ->
    FrameFlags2 = frame_flags(FrameFlags),
    Body = case FrameFlags2 of
        1 -> [?CQL_VERSION, ?LZ4_COMPRESSION];
        0 -> [?CQL_VERSION]
    end,
    marina_frame:encode(#frame {
        stream = ?DEFAULT_STREAM,
        opcode = ?OP_STARTUP,
        flags = FrameFlags2,
        body = marina_types:encode_string_map(Body)
    }).

%% private
flags([]) ->
    0;
flags([{skip_metadata, true} | T]) ->
    2 + flags(T);
flags([{values, true} | T]) ->
    1 + flags(T);
flags([_ | T]) ->
    flags(T).

frame_flags([]) ->
    0;
frame_flags([{compression, true} | T]) ->
    1 + frame_flags(T);
frame_flags([_ | T]) ->
    frame_flags(T).