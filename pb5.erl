%% http://projecteuler.net/index.php?section=problems&id=5
%% What is the smallest number divisible by each of the numbers 1 to 20?
%%
%% 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

%% What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

-module(pb5).
-export([pb5/0]).

pb5 ()->
    is_ok(20).
is_ok(N)->
    io:format("~nDebut de test avec ~p : ", [N]),
    is_divisible(N, 20) orelse is_ok(N+20).
is_divisible(N, 1) ->
    N;
is_divisible(N, X) -> 
    io:format("~p / ~p ?", [N, X]),
    N rem X =:=0 andalso is_divisible(N, X-1).
