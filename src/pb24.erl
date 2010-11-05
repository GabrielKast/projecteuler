%%% File    : pb24.erl
%%% Author  : gabriel <gabriel@Surabaya>
%%% Description : A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
%% 012   021   102   120   201   210
%% What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
%%% Created :  5 Nov 2010 by gabriel <gabriel@Surabaya>

-module(pb24).
-export([pb24/0]).
-export([pb24/2]).
-export([permutations/1]).
-export([old/3]).
pb24()->
    pb24("0123456789", 1000000).
pb24(_List, _Nth)->
    true.
permutations(List)->
    get_permutations(lists:reverse(lists:sort(List)), [], []).
get_permutations(List, Done, Acc)->
    io:fwrite ("> ~p | ~p | ~p ~n", [List, Done, Acc]),
    case List of 
	[] ->
	    io:fwrite ("Done!:~p~n~n", [Done])	    ,
	    lists:reverse(Done) | Acc;
	_ ->
	      New_acc=lists:map(
		fun(Elem)->
			List_filtered = lists:delete(Elem, List),
			get_permutations (List_filtered, [Elem|Done],  Acc)
		end, 
		List)
	    %%	    Result=[ get_permutations (lists:delete(Elem, List), [Elem|Done],  Acc)   || Elem <- List ],
	    %%io:fwrite ("Result:~p~n~n", [Result]),	    
    end.

old(List, Done, Acc)->
    

    case List of 
	[_|_]->
	    Result=lists:map(
	      fun(Elem)->
		      List_filtered = lists:delete(Elem, List),
		      get_permutations (List_filtered, [Elem|Done],  Acc)  
	      end,
	      List),
	    %% io:fwrite ("Result:~p~n~n", [Result]),
	    Result;
	[]->
	    %% io:fwrite("Base case : ~p~n", [Done]),
	    [lists:reverse(Done) | Acc]
    end
.
