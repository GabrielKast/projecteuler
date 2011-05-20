%% Find the only Pythagorean triplet, {a, b, c}, for which a + b + c = 1000.
%% http://projecteuler.net/index.php?section=problems&id=9
%% A Pythagorean triplet is a set of three natural numbers, a  b  c, for which,

%%   a2 + b2 = c2
%%   For example, 32 + 42 = 9 + 16 = 25 = 52.

%% There exists exactly one Pythagorean triplet for which a + b + c = 1000.
%% Find the product abc.
-module (pb9).
-export([pb9/0, is_pythagorean/3]).

pb9()-> L=[{A, B, C} || 
	    C <- lists:seq(1, 997), 
	    B <- lists:seq(1, C), 
	    A <- lists:seq(1, B),
	    A+B+C=:=1000 andalso is_pythagorean(A, B, C)  ],
	[{N1, N2, N3}| _] = L,
	io:format("Result ~w . ~nProduct : ~w ~n ", [L, N1 * N2 * N3 ]).
is_pythagorean(A, B, C)->
    A < B andalso B < C andalso math:pow(A, 2)+math:pow(B, 2)=:=math:pow(C, 2).
