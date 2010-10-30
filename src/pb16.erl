%% 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

%% What is the sum of the digits of the number 2^1000?
-module(pb16).
-export([pb16/0, pb16/1]).
pb16()->
    pb16(1000).
pb16(Exp)->
    lists:sum (lists:map(fun(Elem) -> Elem - 48 end, integer_to_list (exp(2, Exp)))).
exp(N, 1)-> N;
exp(N, Exp)-> 
    exp(N , Exp -1) * N .
