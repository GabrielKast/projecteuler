%% For : http://projecteuler.net
%% 
%% Add all the natural numbers below one thousand that are multiples of 3 or 5.
%% If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
%% Find the sum of all the multiples of 3 or 5 below 1000.
-module(pb1).
-export([pb1/1, pb1/0]).
-import(lists, [seq/3, foldl/3]).

pb1()->
    pb1(10000).

pb1(N)->
    seq(1,N-1, 1).
