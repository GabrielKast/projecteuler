%%%-------------------------------------------------------------------
%%% File    : pb23.erl
%%% Author  : gabriel <gabriel@Surabaya>
%%% Description : 

%%% A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
%%%
%%% A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.
%%% As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. 
%%% By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers.
%%% However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.
%%% Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
%%%
%%% Created : 31 Oct 2010 by gabriel <gabriel@Surabaya>
%%%-------------------------------------------------------------------
-module(pb23).
-export([pb23/0, pb23_v2/0, isAbundant/1, isNotSumOfAbundants/2]).

pb23()->
    Result=notSumOfTwoAbundant(),
    io:format("~n~n~nThe non sum ot 2 abundants : ~p~n~n", [Result]),
    lists:sum(Result).
notSumOfTwoAbundant()->
    Abundants=getAbundants(),
    io:format("Abundants : ~p~n",[Abundants]), 
    lists:filter(
      fun(Elem) -> 
	      isNotSumOfAbundants(Elem, Abundants) 
      end, 
      lists:seq(1, 28123)).

isNotSumOfAbundants(N, Abundants)->
   case lists:any(fun(Elem)->
		      %% Check if Elem + X =N where X is Abundant.
		      %% So the idea is to check if N - Elem is in the list Abundants
		      lists:member(N - Elem, Abundants)
	      end, Abundants) of
       true ->	    false;
       _Else ->true
    end.


pb23_v2()->
    NumbersSum=numbersSumOfAbundants(),
    
    Result = lists:filter(
	       fun(Elem)->
		       case lists:member(Elem, NumbersSum) of 
			   true -> false;
			   _Else -> true
		       end
	       end, 
	       lists:seq(1, 28123)),
    io:format("~n~n~nThe non sum ot 2 abundants : ~p~n~n", [Result]),
    lists:sum(Result).
numbersSumOfAbundants()->
    Abundants = getAbundants(),
    io:format("Abundants : ~p~n",[Abundants]), 
    Sums = [X + Y || X <- Abundants,
	      Y <- Abundants, X+Y < 28123 ],
    remove_duplicates(Sums).

remove_duplicates([H|T]) ->
    case lists:member(H, T) of
	true  -> remove_duplicates(T);
	false -> [H|remove_duplicates(T)]
    end;
remove_duplicates([]) ->
    [].



getAbundants()->
    lists:filter(fun(Elem)-> isAbundant(Elem) end, lists:seq(1, 28123)).
isAbundant(N)->
    lists:sum(getDivisors(N))>N.

%% Get all the divisors for a Number N
getDivisors(N)->
    lists:filter(fun(Elem)->
			 N rem Elem =:=0 end, lists:seq(1, N-1)).
