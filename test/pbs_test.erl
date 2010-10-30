% See http://www.erlang.org/doc/apps/eunit/chapter.html
% Required 
% code:add_path("/usr/lib/erlang/lib/eunit-2.1.4/ebin")


-module(pbs_test).
-include_lib("eunit/include/eunit.hrl").
pb5_test() ->
    ?assertEqual(2520, pb5:pb5(10)).

%% Check that the 6st prime is 13
pb7_test() ->
    ?assertEqual(13, pb7:pb7(6)).

%% Check if is_pythagorean seems ok
pb9_test() ->
    ?assertEqual(true, pb9:is_pythagorean(3, 4, 5)).

%% checks the sample given by pb10 : sum of prime from 2 to 10 is 2+3+5+7=17
pb10_test()->
    {
      timeout, 20, 
      fun() ->
	      ?assertEqual(17, pb10:pb10(10)),
	      ?assertEqual(142913828922,  pb10:pb10()) end
    }.

pb10_v2_test()->
    {
      timeout, 15,
      fun() ->
	      ?assertEqual(142913828922,  pb10:pb10_v2(2000000))
      end
    }.
pb10_v3_test()->
    {
      timeout, 20, 
      fun() ->
	      ?assertEqual(142913828922,  pb10:pb10_v3(2000000))
      end
    }.
pb10_v4_test()->
    {
      timeout, 20, 
      fun() ->
	      ?assertEqual(142913828922,  pb10:pb10_v4(2000000))
      end
    }.
receive_results_test()->
    Pid_acc = spawn(pb10, receive_results, [self(), [], 0, 0] ),
    Pid_acc ! {totalnumber, 5},
    Pid_acc ! {true, 2},
    Pid_acc ! {true, 3},
    Pid_acc ! {true, 5},
    Pid_acc ! {true, 7},
    Pid_acc ! {false, 9},
    receive
	List ->
	    io:format("Reception de la liste : ~p~n", [List]),
	    ?assertEqual(17, lists:sum(List))
    end.

get_divisors_test()->
    ?assertEqual([1, 2, 4, 5, 10, 11, 20, 22, 44, 55, 110], pb21:get_divisors(220)),
    ?assertEqual([1, 2, 4, 71, 142], pb21:get_divisors(284)).


factorial_test()->
    ?assertEqual(5*4*3*2, pb20:factorial(5)).

pb8_test()->
    ?assertEqual(5*6*7*8*9, pb8:pb8(123456789)),
    ?assertEqual(7*8*9*8*7, pb8:pb8(123456789870)).

pb14_test()->
    Z=pb14:sequenceSize(13),
    ?assertEqual(10, Z),
    ?assertEqual(9, pb14:pb14(13)).

integer_to_litteral_test() ->
    ?assertEqual("two hundred", pb17:integer_to_litteral(200)),
    ?assertEqual("five hundred", pb17:integer_to_litteral(500)),
    ?assertEqual("one thousand", pb17:integer_to_litteral(1000)),
    ?assertEqual("one thousand three hundred", pb17:integer_to_litteral(1300)),
    ?assertEqual("seven thousand four hundred", pb17:integer_to_litteral(7400)),
    ?assertEqual("seven hundred and twenty", pb17:integer_to_litteral(720)),
    ?assertEqual("seven hundred and twenty-eight", pb17:integer_to_litteral(728)),
    ?assertEqual("nine hundred and four", pb17:integer_to_litteral(904)),
    ?assertEqual("twenty-one", pb17:integer_to_litteral(21)),
    ?assertEqual("eighty", pb17:integer_to_litteral(80)),
    ?assertEqual("eight", pb17:integer_to_litteral(8)),
    ?assertEqual("one", pb17:integer_to_litteral(1)),
    ?assertEqual("three hundred and forty-two", pb17:integer_to_litteral(342)),
    ?assertEqual("one thousand nine hundred and ninety-nine", pb17:integer_to_litteral(1999))
.
count_letter_test()->
    ?assertEqual(length("threehundredandfortytwo"), pb17:count_letter("three hundred and forty-two")),
    ?assertEqual(3, pb17:count_letter("one")).
pb17_test() ->
    ?assertEqual(pb17:count_letter ("one two three four five six seven"), pb17:pb17(7)),
    ?assertEqual(pb17:count_letter ("one two three four five six seven eight nine ten eleven twelve"), pb17:pb17(12)),
    ?assertEqual(21124, pb17:pb17()).
