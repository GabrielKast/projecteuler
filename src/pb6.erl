%% http://projecteuler.net/index.php?section=problems&id=6
%% What is the difference between the sum of the squares and the square of the sums?

%% The sum of the squares of the first ten natural numbers is,

%% 1^2 + 2^2 + ... + 10^2 = 385
%% The square of the sum of the first ten natural numbers is,

%% (1 + 2 + ... + 10)^2 = 55^2 = 3025
%% Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025  385 = 2640.

%% Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
-module(pb6).
-export([pb6/0]).

pb6()-> 
    pb6(100).

pb6(N) -> square_of_sum(N) - sum_of_square(N).
sum_of_square(N) -> lists:sum (lists:map (fun (Elem) -> math:pow(Elem, 2) end, lists:seq(1, N))).
square_of_sum(N) -> math:pow( lists:sum (lists:seq(1, N)), 2).
