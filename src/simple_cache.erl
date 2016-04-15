-module(simple_cache).
-export([insert/2, lookup/1, delete/1, connect/0]).

insert(Key, Value) ->
  case sc_store:lookup(Key) of 
    {ok, Pid} ->
      sc_element:replace(Pid, Value);
    {error, _} ->
      {ok, Pid} = sc_element:create(Value),
      sc_store:insert(Key, Pid)
  end.

lookup(Key) ->
  try
    {ok, Pid} = sc_store:lookup(Key),
    {ok, Value} = sc_element:fetch(Pid),
    {ok, Value} 
  catch
    _Class:_Exception ->
      {errror, not_found}
  end.

delete(Key) ->
  case sc_store:lookup(Key) of
    {ok, Pid} ->
      sc_element:delete(Pid);
    {error, _Reason} ->
      ok
  end.

connect(Token) ->
  Endpoint = "rtm.start",
  io:format("Hello, world!~n"),
  { ok, Status, Metadata, Response} = slacker_request:send("rtm.start", [{"token",
                                                         Token}]),
  [Url | _ ] = [X || { <<"url">>, X } <- Response ],
  ActualUrl = binary_to_list(Url),
  io:format(ActualUrl),

  ws_handler:start_link(ActualUrl).

