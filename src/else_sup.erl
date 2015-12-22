-module(else_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
	{ok, _} = ranch:start_listener(tcp_echo, 100,
		ranch_tcp, [{port, 5555}],
		player_protocol, []
	),
	io:format("start ranch ok ", []),
	Procs = [],
	{ok, {{one_for_one, 1, 5}, Procs}}.
