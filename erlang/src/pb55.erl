%%% File    : pb55.erl
%%% Author  : gabriel <gabriel@Surabaya>
%%% Description : http://projecteuler.net/index.php?section=problems&id=55
%%% Created :  7 Nov 2010 by gabriel <gabriel@Surabaya>

-module(pb55).
-export([pb55/0]).
-export([is_Lychrel/1]).

pb55()->
    Results = lists:filter (fun(Elem) -> is_Lychrel(Elem) end, lists:seq(1, 10000)),
    io:fwrite("List of Lychrel numbers ~p~n", [Results]),
    length(Results).

is_Lychrel(N)-> is_Lychrel(N+list_to_integer(lists:reverse(integer_to_list(N))), 50).
is_Lychrel(_, 0)->
    true;
is_Lychrel(N, Nth)->
    N_string=integer_to_list(N),
    N_reverse=lists:reverse(N_string),
    %% io:fwrite("test de ~p~n", [N]),
    case N_reverse=/= N_string of
       true -> is_Lychrel(N+list_to_integer(N_reverse), Nth - 1 );
       _ -> false
    end.


