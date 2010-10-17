%% http://projecteuler.net/index.php?section=problems&id=5
%% What is the smallest number divisible by each of the numbers 1 to 20?
%%
%% 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

%% What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

-module(pb5).
-export([pb5/0, pb5/1]).

pb5 ()->
    is_ok(20, 20).
pb5 (Pas) -> is_ok(Pas, Pas). 
is_ok(N, Pas)->
    % io:format("~nDebut de test avec ~p : ", [N]),
    is_divisible(N, Pas) orelse is_ok(N+Pas, Pas).

is_divisible(N, 1) ->
    io:format("Trouve : ~p~n", [N]),
    true;
is_divisible(N, X) -> 
    % io:format("~p / ~p ?", [N, X]),
    N rem X =:=0 andalso is_divisible(N, X-1).
