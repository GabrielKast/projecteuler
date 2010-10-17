%% http://projecteuler.net/index.php?section=problems&id=3
%% Find the largest prime factor of a composite number.
%%
%% The prime factors of 13195 are 5, 7, 13 and 29.
%% What is the largest prime factor of the number 600851475143 ?
%%
-module(pb3).
-export([pb3/0, is_prime/1]).

pb3()-> 
    N=600851475143,
    PlusHaut = ceiling (math:sqrt(N)),
    recherche_plus_haut_diviseur(N, PlusHaut).

recherche_plus_haut_diviseur(N, X)->
    if N rem X =:=0 -> 
	    case  is_prime(X) of 
		true  -> X;
		_ -> recherche_plus_haut_diviseur(N , X-1)
	    end;
       X =:=1 -> 1;
       X rem 2 =:=0 ->  recherche_plus_haut_diviseur(N , X-1);
       true -> recherche_plus_haut_diviseur(N , X-2)
       end.

ceiling(X) ->
    case trunc(X) of 
	Y when Y < X -> Y + 1; 
	Z   -> Z
    end.

is_prime(N) ->
    if N =< 3 -> true;
       true -> not is_divisible(N, 2)
    end.

is_divisible(N, 2) ->
    if N rem 2 =:=0 -> true;
       N > 3 -> is_divisible (N, 3)
    end;
is_divisible(N, X) ->
    if N rem X =:=0 ->
	    true;
       N > X*X -> is_divisible(N, X+2);
       true -> false
    end.



