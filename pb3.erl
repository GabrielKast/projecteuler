%% http://projecteuler.net/index.php?section=problems&id=3
%% Find the largest prime factor of a composite number.
%%
%% The prime factors of 13195 are 5, 7, 13 and 29.
%% What is the largest prime factor of the number 600851475143 ?
%%
-module(pb3).
-export([pb3/0, is_prime/1]).

pb3()-> 
    .

is_prime(N) ->
    if N = < 3 -> true;
       _Else -> not is_divisible(N, 2).

is_divisible(N, 2) ->
    if N rem 2 =:=0 -> true;
       N > 3 -> is_divisible (N, 3)
    end;
is_divisible(N, X) ->
    if N rem X =:=0 ->
	    true;
       N > X*X -> is_diviible(N, X+2);
       _Else -> false
    end.



