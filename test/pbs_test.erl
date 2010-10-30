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
