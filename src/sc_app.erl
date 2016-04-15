-module(sc_app).
-behaviour(application).
-export([start/0, start/2, stop/1]).

-define(DEPS, [crypto, asn1, public_key, ssl, inets, idna, hackney, restc]).

start() ->
  sc_store:init(),
  case sc_sup:start_link() of 
    {ok, Pid} ->
      {ok, Pid};
    Other ->
      {error, Other}
  end.

start(_StartType, _StartArgs) ->
  [application:start(A) || A <- ?DEPS],
  sc_store:init(),
  case sc_sup:start_link() of 
    {ok, Pid} ->
      {ok, Pid};
    Other ->
      {error, Other}
  end.

stop(_State) ->
  ok.
