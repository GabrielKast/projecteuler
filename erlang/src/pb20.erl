%% n! means n  (n  1)  ...  3  2  1
%% Find the sum of the digits in the number 100!
-module(pb20).
-export([pb20/0, pb20/1, factorial/1]).

pb20() ->
    pb20(100).
pb20(Number)->
    Calcul=factorial(Number),
    Result=lists:foldl(
	     fun(Elem, Sum) -> Sum + Elem - 48 end , 
	     0,  
	     integer_to_list(Calcul)),
    io:format("#Factoriel ~p~n Sum on the digits : ~p ~n", [Calcul, Result]).
factorial(1)->
    1;
factorial(Number)->
    Number * factorial(Number -1).
