% Required 
% code:add_path("/usr/lib/erlang/lib/eunit-2.1.4/ebin").

-module(pbs_tests).
-include_lib("eunit/include/eunit.hrl").

pb5_test() ->
    ?assertEqual(2520, pb5:pb5(10)).

