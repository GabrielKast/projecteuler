%%%-------------------------------------------------------------------
%%% File    : pb40.erl
%%% Author  : gabriel <gabriel@Surabaya>
%%% Description : An irrational decimal fraction is created by concatenating the positive integers:
%%% 0.123456789101112131415161718192021...

%%% It can be seen that the 12th digit of the fractional part is 1.

%%% If dn represents the nth digit of the fractional part, find the value of the following expression.

%%% d1 *  d10 *  d100 * d1000 * d10000 * d100000 * d1000000
%%%
%%% Created : 31 Oct 2010 by gabriel <gabriel@Surabaya>
%%%-------------------------------------------------------------------
-module(pb40).
-export([pb40_old/0, pb40/0, createNumber/1, getDigit2/1]).
pb40_old()->
    Number = createNumber(1000000),
    io:format("Longueur ~p~n", [length(Number)]),
    Result = getDigit(Number, 1) * getDigit(Number, 10) * getDigit(Number, 100) * getDigit(Number, 1000) * getDigit(Number, 10000) *  getDigit(Number, 100000) *  getDigit(Number, 1000000),
    io:format("Result= ~p~n", [Result]) .

createNumber(Length)->
    createNumber(Length, "", 1).
createNumber(Length, Acc, Number) ->
    if length(Acc)<Length ->
	    createNumber(Length, string:concat(Acc, integer_to_list(Number)), Number+1);
       true ->
	    Acc
    end.
getDigit(String, Index)->
    {V, _}=string:to_integer(string:substr(String, Index, 1)),
    V.


%% Same way to find but I do not create a String. It is much much faster :D
%% And it's not optimised !

pb40()->
    Result = getDigit2(1) 
	* getDigit2(10) 
	* getDigit2(100) 
	* getDigit2(1000) 
	* getDigit2(10000) 
	* getDigit2(100000) 
	* getDigit2(1000000),
    Result.

getDigit2(Searched)->
    getDigit2(Searched, 0, 1).
getDigit2(Searched, Length, Counter)->
    %% Instead of creating the String I do as if ... 
    %% I just calculate the length of the not-created String
    %% 
    ResultLength=Length + length(integer_to_list(Counter)),
    if ResultLength>=Searched ->
	    %% Founded
	    %% Here this Digits could be the old added (if there was a String)
	    %% So we find the Searched Digits
	    %% Let's say it's the 10th. We already added 9 . 
	    %% So the Char to find is 10 - 9 = 1st one
	    {Digit, _}=string:to_integer(
			 string:substr(integer_to_list(Counter), Searched - Length, 1) ),
	    Digit
	    ;
       true -> getDigit2(Searched, ResultLength, Counter+1)
    end.
