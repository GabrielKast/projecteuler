%% http://projecteuler.net/index.php?section=problems&id=7
%% By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

%% What is the 10001st prime number?
-module(pb7).
-import(pb3, [is_prime/1]).
-export([pb7/0, pb7/1]).

pb7()->
    pb7(10001).
pb7(N)->
    L=list_of_prime(2, N, 0,  []), 
    lists:last(L).
list_of_prime(X, N, Size_List, List)->
    Next_Prime= X+1 + (X rem 2),
    case { is_prime (X), Size_List+1 } of
	    {true,  N } ->
		    lists:reverse([ X | List ])  ; %% End of the search
	    {true, _ } ->
		    list_of_prime (Next_Prime, N, Size_List+1, [ X|List ]);
	    {false, _ } ->
		    list_of_prime (Next_Prime, N, Size_List, List)
    end.


			

