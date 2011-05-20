%%The following iterative sequence is defined for the set of positive integers:

%% n -> n/2 (n is even)
%% n  -> 3n + 1 (n is odd)

%% Using the rule above and starting with 13, we generate the following sequence:

%% 13  40  20  10  5  16  8  4  2  1
%%It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

%% Which starting number, under one million, produces the longest chain?

%% NOTE: Once the chain starts the terms are allowed to go above one million.

-module(pb14).
-export([pb14/0, pb14/1, sequenceSizeProcess/0, sequenceSize/1, sequenceSize2/1]).
pb14()->
    pb14(1000000).
pb14(Limit)->
    %% Find the longest sequence for all the number from 1 to N
    register(sequence_process, spawn (pb14, sequenceSizeProcess, [])),
    {Founded, LonguestSequence}=getlonguestsequence(1, Limit, {0, 0}), 
    io:format("Result {founded, nb of tranformation needed} : ~p~n", [{Founded, LonguestSequence}]),
    sequence_process ! stop,
    Founded.

getlonguestsequence(X, Limit, {Founded, LonguestSequence}) when X<Limit ->    
    sequence_process ! {self(), X, nocache},
    receive
	Sequence -> true %% We've got the number
    end,
    %% io:format("Result founded for ~p : ~p ~n", [X, Sequence]),
    case Sequence>LonguestSequence of
	true->getlonguestsequence(X+1, Limit, {X, Sequence});
	_Else->getlonguestsequence(X+1, Limit, {Founded, LonguestSequence})
    end;
getlonguestsequence(_, _, {Founded, LonguestSequence})  ->    
    {Founded, LonguestSequence}.


sequenceSizeProcess()->
    doSequenceSizeProcess(dict:new()).

doSequenceSizeProcess(Dict)->
    receive
	{From, Number, nocache} ->
	    Result = sequenceSize(Number),
	    From ! Result,
	    doSequenceSizeProcess(Dict);

	{From, Number, cache} ->
	    Result = sequenceSize2(Number, Dict),
	    From ! Result,
	    doSequenceSizeProcess(dict:store (Number, Result, Dict));
	stop -> true
    end.

%% No cache. Just an easy to test that function.
sequenceSize(N)->
    sequenceSize(N, 0).
sequenceSize(N, NbTransformation) when N=/=1 ->
    %% io:format("~p -> ", [N]),
    sequenceSize(f(N), NbTransformation +1);
sequenceSize(N, NbTransformation) when N=:=1 ->
   %% io:format("1 ! ~n"),
   NbTransformation+1 .

%% Tried to add a dict . The performance were terrible!!
sequenceSize2(N)->
    sequenceSize2(N, 0, dict:new()).

sequenceSize2(N, Dict)->
    sequenceSize2(N, 0, Dict).

sequenceSize2(N, NbTransformation, Dict) when N=/=1 ->
    %% io:format("~p -> ", [N]),
    case dict:find(N, Dict) of
	error -> 
	    %%Get the real value and put it in the cache (the dict)
	    sequenceSize2(f(N), NbTransformation +1, Dict);
	{ok, Result } ->
	    %% Get the value from the cache
	    %% io:format("Founded for ~p : ~p ~n ", [N, Result]),
	    Result+ NbTransformation
    end;
sequenceSize2(N, NbTransformation, _Dict) when N=:=1 ->
   %% io:format("1 ! ~n"),
   NbTransformation+1 .
    

f(N) when N rem 2 =:=0 ->
    N div 2;
f(N) ->
    ( 3 * N) +1.


