%% http://projecteuler.net/index.php?section=problems&id=10
%% The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
%% Find the sum of all the primes below two million.
-module(pb10).
-import(pb3, [is_prime/1]).
-export([pb10/0, pb10/1, pb10_v2/1, pb10_v3/1, pb10_v4/1, receive_results/4, pool_manager/4, is_prime_async/2]).
pb10() ->
    pb10(2000000).
pb10(Limit)->
    sum_of_prime(2, Limit, 0).
sum_of_prime(Number, To, Sum)->
    case Number<To of
	true -> 
	    case is_prime(Number) of
		true->
		    sum_of_prime(next_number(Number), To, Sum+Number); 
		_ ->sum_of_prime(next_number(Number), To, Sum)
	       end;
	false -> Sum 
    end.
next_number (Number)->
    case Number rem 2 =:=0  of
	true ->
	    Number + 1;
	_ -> 
	    Number + 2
    end.

%% New version with parallelism
pb10_v2(Limit) ->
    L=list_of_prime (2, Limit, []),
    lists:sum(L).

list_of_prime(Number, Limit, ListOfPrime) ->
    % 
    % If we can create a new process to see if Number is Prime let's do it
    if Number =< Limit  -> 
	    case is_prime(Number) of
		true ->
		    list_of_prime(next_number(Number), Limit, [Number | ListOfPrime]);
		_ ->
		    list_of_prime(next_number(Number), Limit, ListOfPrime)
	    end;
	true -> ListOfPrime
    end.

%% Function that can accumulate results
%% You set the total number of results. 
%% Then when you have all the results it sends a message back to the PidInit
receive_results(PidInit, ListOfResult, NbOfTreated, TotalOfMessages) ->
    receive
	%% Set total number of messages
	{totalnumber, Number}->
	    do_loop_or_not(PidInit, ListOfResult, NbOfTreated , Number);
 	%% Number is prime
	{true, Number} -> 
	    do_loop_or_not(PidInit, [Number | ListOfResult], NbOfTreated +1, TotalOfMessages);
	%% Number is not prime
	{false, _Number} -> 
	    do_loop_or_not(PidInit, ListOfResult, NbOfTreated +1, TotalOfMessages);
	%% What ?
	_Mess ->io:format("He?? Unknown message ~p~n", [_Mess]),
	    do_loop_or_not(PidInit, ListOfResult, NbOfTreated , TotalOfMessages)
    end.

do_loop_or_not(PidInit, ListOfResult, NbOfTreated, TotalOfMessages) ->
    case NbOfTreated =/= TotalOfMessages of
	true -> receive_results(PidInit, ListOfResult, NbOfTreated, TotalOfMessages);
	_ ->  PidInit ! ListOfResult,
	      void
    end.

	       
pb10_v3(Limit) ->
    %% For each number, launch a process that will receive all the response
    Pid_reduce = spawn(pb10, receive_results, [self(), [], 0, 0] ),
    for_each(2, Limit, Pid_reduce, 0),
    doreceive_result().

for_each(Number, Limit, Pid_reduce, TotalNumber)->
    if Number =< Limit ->
	    Pid_reduce ! { is_prime(Number), Number },
	    for_each(next_number(Number), Limit, Pid_reduce, TotalNumber+1);
       true -> Pid_reduce ! {totalnumber, TotalNumber},
	       void
    end.
	       
pb10_v4(Limit) ->
    %% For each number, launch a process that will receive all the response
    Pid_reduce = spawn(pb10, receive_results, [self(), [], 0, 0] ),
    Pid_pool = spawn (pb10, pool_manager, [self(), 0, [], Pid_reduce]),
    for_each_parallel(2, Limit, Pid_pool, Pid_reduce, 0),
    doreceive_result().

pool_manager(PidInit, NbOfProcess, ListBuffer, Pid_reduce) ->
	    io:format("ICI~n"),
    receive
	{checkprime, Number} when NbOfProcess < 10000 -> 
%%	    io:format("Checkprime~n"),
	    do_checkprime(self(), Number, Pid_reduce),
	    pool_manager(PidInit, NbOfProcess +1 , ListBuffer, Pid_reduce);
	{checkprime, Number}  ->
%%	    io:format("Checkprime buffer~n"),
	    pool_manager(PidInit, NbOfProcess , [Number | ListBuffer], Pid_reduce);   
	{checkprime} when NbOfProcess <3 ->
	    case ListBuffer of
		[H|Tail] -> 
%%		    io:format("Checkprime : reprise d'un process ~n"),
		    do_checkprime(self(), H, Pid_reduce),
		    pool_manager(PidInit, NbOfProcess -1+1 , Tail, Pid_reduce);
		%% Nothing to do
		_ -> %% io:format("Nothing to do~n"),
		     pool_manager(PidInit, NbOfProcess , ListBuffer, Pid_reduce)
	    end;
	%% Nothing to do... But wait for a new process
	{checkprime}   -> %% io:format("Still too much process~n"),
			  pool_manager(PidInit, NbOfProcess -1 , ListBuffer, Pid_reduce);

	Other   -> io:format("What is ~p ? ~n", [Other]),
			  pool_manager(PidInit, NbOfProcess -1 , ListBuffer, Pid_reduce)	     end.

for_each_parallel(Number, Limit, Pid_pool, Pid_reduce, TotalNumber)->
    if Number =< Limit ->
	    Pid_pool ! { checkprime, Number },
	    for_each_parallel(next_number(Number), Limit, Pid_pool, Pid_reduce, TotalNumber+1);
       true -> Pid_reduce ! {totalnumber, TotalNumber},
	       void
    end.

do_checkprime(Caller, Number, Pid_reduce) ->
    Pid=spawn (pb10, is_prime_async, [Caller, Pid_reduce]),
    Pid ! Number.


is_prime_async(Caller, Pid_reduce) ->
    receive
	Number ->
	    IsPrime= is_prime(Number),
%%	    io:format("Resultat pour ~p : ~p ~n", [Number, IsPrime]),
	    Pid_reduce ! {IsPrime, Number},
	    Caller ! {checkprime}
    end.
doreceive_result()->
    receive
	List ->io:format ("Result : ~p~n", [Result=lists:sum(List)]),
	       Result
    end.

rpc(Pid, Request) ->
    Pid ! { self(), Request },
    receive Response ->
	    Response
    end.

