%%%-------------------------------------------------------------------
%%% File    : pb25.erl
%%% Author  : gabriel <gabriel@Surabaya>
%%% Description : 
%%% The Fibonacci sequence is defined by the recurrence relation:
%%% 
%%% Fn = Fn1 + Fn2, where F1 = 1 and F2 = 1.
%%% Hence the first 12 terms will be:
%%%
%%% F1 = 1
%%% F2 = 1
%%% F3 = 2
%%% F4 = 3
%%% F5 = 5
%%% F6 = 8
%%% F7 = 13
%%% F8 = 21
%%% F9 = 34
%%% F10 = 55
%%% F11 = 89
%%% F12 = 144
%%% The 12th term, F12, is the first term to contain three digits.
%%% 
%%% What is the first term in the Fibonacci sequence to contain 1000 digits?
%%%
%%% Created : 31 Oct 2010 by gabriel <gabriel@Surabaya>
%%%-------------------------------------------------------------------
-module(pb25).
-export([pb25/0, pb25/1]).

pb25()->
    pb25(1000).
pb25(NumberOfDigits)->
    search(NumberOfDigits, 3, 1, 1).
search(NumberOfDigits, Index, FiboNMinus1, FiboNMinus2)->
    NewFiboNumber = FiboNMinus1 + FiboNMinus2,
    Result=length(integer_to_list(NewFiboNumber)),
    if
	Result<NumberOfDigits ->
	    search(NumberOfDigits, Index+1, NewFiboNumber, FiboNMinus1);
	true -> Index
    end.
