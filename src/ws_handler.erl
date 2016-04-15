-module(ws_handler).

-behavior(websocket_client_handler).

-export([
         start_link/1,
         init/2,
         websocket_handle/3,
         websocket_info/3,
         websocket_terminate/3
        ]).

init([], _ConnState) ->
    io:format("Here ~n"),
    %% websocket_client:cast(self(), {text, <<"message 1">>}),
    %% Execute a ping every 1000 milliseconds
    {ok, 2, 1000}.

start_link(URL) ->
  crypto:start(),
  ssl:start(),
  websocket_client:start_link(URL, ?MODULE, []).

websocket_handle({pong, _Msg}, _ConnState, State) ->
  io:format("Received pong ~n"),

  {ok, State};

websocket_handle({ping, _Msg}, _ConnState, State) ->
  io:format("Received ping ~n"),
  {ok, State};

websocket_handle({text, Msg}, _ConnState, State) ->
  io:format("Received msg ~p~n", [Msg]),
  {ok, State};

websocket_handle({binary, _Msg}, _ConnState, State) ->
    io:format("Received pong ~n"),

  {ok, State}.
    
websocket_info(start, _ConnState, State) ->
    {reply, {text, <<"erlang message received">>}, State}.

websocket_terminate(Reason, _ConnState, State) ->
    io:format("Websocket closed in state ~p wih reason ~p~n",
              [State, Reason]),
    ok.
