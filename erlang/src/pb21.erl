%% Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
%% If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.

%% For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

%% Evaluate the sum of all the amicable numbers under 10000.
%% http://projecteuler.net/index.php?section=problems&id=21
-module (pb21).
-export([pb21/0, pb21/1, get_divisors/1, is_amicable/2]).

pb21()->
    pb21(10000).

pb21(Limit)-> 
    Results=lists:filter(
      fun(Elem) -> 
	      Sum1=lists:sum(get_divisors(Elem)),
		  is_amicable(Elem, Sum1) andalso Elem=/=Sum1
		  end, lists:seq (2, Limit)),
    io:format("Resultat : ~p~n~nSomme: ~p~n", [Results, lists:sum(Results)]).

get_divisors(Number)->
    lists:filter (fun (Elem) -> (Number rem Elem =:=0) end , lists:seq(1, Number-1, 1) ).
is_amicable(Number, Number2)->
    Number=:=lists:sum(get_divisors(Number2)).

