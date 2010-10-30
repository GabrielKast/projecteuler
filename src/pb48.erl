%% The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.

%% Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.

-module(pb48).
-export([pb48/0, pb48/1]).

pb48()->
    pb48(1000).
pb48(N)->
    lists:sum(lists:map (fun(Elem) ->exp(Elem, Elem) end, lists:seq(1, N))).
exp(N, 1)-> N;
exp(N, Exp)-> 
    exp(N , Exp -1) * N .

