%% How many letters would be needed to write all the numbers in words from 1 to 1000?
%% If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

%% If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?


%% NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.

-module(pb17).
-export([pb17/0, pb17/1, integer_to_litteral/1, count_letter/1]).

pb17()->
    pb17(1000).
pb17(N)->
      lists:sum (lists:map (
		   fun (Elem) -> count_letter (integer_to_litteral(Elem)) end
	       , lists:seq (1, N))).

count_letter(Litteral)->
    doCount(Litteral, 1, length(Litteral), 0).
doCount(Litteral, Index, Bound, Number) when Bound>=Index ->
    Character = string:substr (Litteral, Index, 1),
    if Character =:= " " orelse Character =:= "-" ->
	    doCount(Litteral, Index+1, Bound, Number);
	true -> doCount(Litteral, Index+1, Bound, Number +1)
    end;
doCount(_Litteral, _Index, _Bound,  Number)  -> Number.

			      

integer_to_litteral(N)->
    Result_1000 = getLitteralThousand(N), 
    Result_100 = getLitteralHundred(N), 
    Result_10 = getLitteralDozen(N),
    Result_Separ1 = if Result_1000=:="" -> "";
		       Result_100 =/="" -> " ";
		       Result_100 =:="" -> ""
		    end,
    Result_Separ2 = if Result_100=/="" andalso Result_10 =/= "" ->
			    " and ";
		       Result_1000=/="" andalso Result_10 =/= "" ->
			    " ";
		       true -> ""
		    end,
    Result = lists:flatten ([Result_1000, Result_Separ1, Result_100, Result_Separ2, Result_10]),
    Result.

getLitteralThousand(N)->
    case N div 1000 of
	0 -> "";
	X when X<20 -> string:concat (getNumber(X), " thousand");
	_Else -> erlang:error("unsupported_exception")
    end.

getLitteralHundred(N)->
    OnlyHundred=N - (N div 1000) * 1000,
    case (OnlyHundred div 100) of
	0 -> "";
	X when X<10 -> string:concat (getNumber(X), " hundred");
	_Else -> erlang:error("unsupported_exception")
    end.

getLitteralDozen(N)->
    OnlyDozen = N - (N div 100) * 100,
    % io:format ("OnlyDozen : ~p~n", [OnlyDozen]),
    if OnlyDozen < 20 ->
	    %% case from 1 to 19
	    getNumber(OnlyDozen);
	true -> Dozen = (OnlyDozen div 10) * 10,
		LastOne = OnlyDozen - Dozen,
		% io:format ("Dozen ~p and LastOne : ~p~n", [Dozen, LastOne]),
		Result_Dozen = getDozen(OnlyDozen - LastOne),
		Result_LastOne = getNumber(LastOne),
		Result_SeparLast=
		    if Result_LastOne =:="" -> "";
		       true -> "-"
		    end,
		lists:flatten ([Result_Dozen, Result_SeparLast, Result_LastOne])
    end.


getNumber(X)->
    case X of 
	0 -> "";
	1 -> "one";
	2 -> "two";
	3 -> "three";
	4 -> "four";
	5 -> "five";
	6 -> "six";
	7 -> "seven";
	8 -> "eight";
	9 -> "nine";
	10 -> "ten";
	11 -> "eleven";
	12 -> "twelve";
	13 -> "thirteen";
	14 -> "fourteen";
	15 -> "fifteen";
	16 -> "sixteen";
	17 -> "seventeen";
	18 -> "eighteen";
	19 -> "nineteen";
	_Else -> erlang:error(string:concat ("Unsupported Number : ", integer_to_list(_Else)))
    end.

getDozen(Dozen)->
    case Dozen of 
	20 -> "twenty";
	30 -> "thirty";
	40 -> "forty";
	50 -> "fifty";
	60 -> "sixty";
	70 -> "seventy";
	80 -> "eighty";
	90 -> "ninety";
	_Else -> erlang:error(string:concat ("Unsupported Number : ", integer_to_list(_Else)))
    end.
