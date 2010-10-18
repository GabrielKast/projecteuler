% Required 
% code:add_path("/usr/lib/erlang/lib/eunit-2.1.4/ebin")


-module(pbs_tests).
-include_lib("eunit/include/eunit.hrl").
pb5_test() ->
    ?assertEqual(2520, pb5:pb5(10)).

%% Check that the 6st prime is 13
pb7_test() ->
    ?assertEqual(13, pb7:pb7(6)).

%% Check if is_pythagorean seems ok
pb9_test() ->
    ?assertEqual(true, pb9:is_pythagorean(3, 4, 5)).