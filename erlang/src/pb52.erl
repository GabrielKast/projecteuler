%%% File    : pb52.erl
%%% Author  : gabriel <gabriel@Surabaya>
%%% Description : It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.
%%% Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.
%%% Created :  7 Nov 2010 by gabriel <gabriel@Surabaya>

-module(pb52).
-export([pb52/0]).
-export([is_with_same_digits/2]).
pb52() ->
     search (1).
search (N)->
    X = integer_to_list(N),
    case is_with_same_digits(X, maybe(N, 6)) 
	andalso is_with_same_digits(X, maybe(N, 5) )
	andalso is_with_same_digits(X, maybe(N, 4) )
	andalso is_with_same_digits(X, maybe(N, 3) )
	andalso is_with_same_digits(X, maybe(N, 2) )
    of
       true  -> N;
       _Else -> search(N+1) 
    end.
maybe(N, X)->
    integer_to_list(N*X).
is_with_same_digits(X, Y) ->
    if length(X)=/=length(Y)
       -> false ;
       true -> lists:sort(X)=:=lists:sort(Y)
    end.


