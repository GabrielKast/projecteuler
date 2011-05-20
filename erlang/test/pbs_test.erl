% See http://www.erlang.org/doc/apps/eunit/chapter.html
% Required 
% code:add_path("/usr/lib/erlang/lib/eunit-2.1.4/ebin")


-module(pbs_test).
-include_lib("eunit/include/eunit.hrl").
pb1_test()->
    23331668=pb1:pb1().
pb5_test() ->
    ?assertEqual(2520, pb5:pb5(10)).

%% Check that the 6st prime is 13
pb7_test() ->
    ?assertEqual(13, pb7:pb7(6)).

%% Check if is_pythagorean seems ok
pb9_test() ->
    ?assertEqual(true, pb9:is_pythagorean(3, 4, 5)).

%% checks the sample given by pb10 : sum of prime from 2 to 10 is 2+3+5+7=17
pb10_test_()->
    {
      timeout, 20, 
      fun() ->
	      ?assertEqual(17, pb10:pb10(10)),
	      ?assertEqual(142913828922,  pb10:pb10()) end
    }.

%% pb10_v2_test_()->
%%     {
%%       timeout, 15,
%%       fun() ->
%% 	      ?assertEqual(142913828922,  pb10:pb10_v2(2000000))
%%       end
%%     }.
%% pb10_v3_test_()->
%%     {
%%       timeout, 20, 
%%       fun() ->
%% 	      ?assertEqual(142913828922,  pb10:pb10_v3(2000000))
%%       end
%%     }.
%% Too long
%% pb10_v4_test_()->
%%     {
%%       timeout, 20, 
%%       fun() ->
%% 	      ?assertEqual(142913828922,  pb10:pb10_v4(2000000))
%%       end
%%     }.
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
pb48_test()->
    ?assertEqual(10405071317, pb48:pb48(10)),
    ?assertEqual(1000368199144695177095375011227646795567793680622934654583760988100234910747716194381428659099527845945869942643191290894720342979906407679647259860434238468038326040809691037615370376237713648510063115732951461774246705584266865759601815843666442832284556880313114548151539190975398485496645576513465858582712336401166221956188173449531674102688908321764663020306699770408625340766091595022791379368098369306375602813856646358773751558775213460225796579846583334007349358624342339332981334571237888809283103348760261360175950815609179464026871005243652109980863552142014242903434068560936573231079342194031864413918101238151056509267393515760392842472501391594073463001521843811073767021711026307504695733467897821866906648469828346607412967395801797791683609834722432241952845352564681868240369569566192825555323558078061997527689983848863374786789331581565252059172614339424600986143259233167583371070362625554531852054166117148858229508581589614337594463277554380518380921301218836327102231407332201109740102580216469298331766920619646083790732807627360614428085171565006289728508688964226799647192582924058589530750674578385365561878559589685756225692348914746922810913915619834754117648358035814128670294158565669942087736286390942241547226015004471330630113072042704288905042142628193771918594574302202147201188486345913190833752307476966010547423928871063118783026036381319039052008252072057933666712918946233312793697094074224187872045970976444309242782187738320257490080824330074991698698239561125811127607863900355221737846690567707344074494145266662103839812840216303448476913957072355732716627098372245223046792919747259113157425824064858331415400943278213042954635053574045209984512221264241903550178416824551412548637590007779082539288247751653566899882749594405895102587985539527709493510049546445427265617478399107188238681771215904234119392247489751079085948055945098805617963722928469554263782217625160428008228845552540344494860195267115187092227766195753907211126646150140614744233974765273475619964311852858614167819668340124730487710162006793529985758820653677274379563313495454526632718723482339494825759821076401694316043456512117937935456463521463021197726694983558929132357576188594977516630734212863869456164205525536767311298137182511494649463663073759219213056823561667776093739425742883930712609962163464088038826569132032160692637206183085942987973684584276491784843115472077900401692595694119273553511025991265446039366288921743581333200083717105241171504606883543418862024047552177055263424469501298905901938158245938633694105024815166679813689156668341197713475094389904887126794468901893850475050011205225742455555625750560213230387910337983950333245020653238989115507013882956277763880795687210857196493893142656713105966275422144605988058939600603604226921401402096519294250488670297983396353279460453142375542267881989197481789780678955093763193658603690898474826976906544473978017455720367929981796023041785852626797271283465789498383642350667978127819110846700, pb48:pb48())
.


pb13_test()->
    ?assertEqual("5537376230", pb13:pb13()).

pb25_test()->
    ?assertEqual(12, pb25:pb25(3)),
    ?assertEqual(4782, pb25:pb25()).

scores_test()->
    ?assertEqual(49714, pb22:getScore("COLIN", 938)),
    ?assertEqual(871198282, pb22:pb22()).

pb40_test()->
    ?assertEqual(210, pb40:pb40()).


isAbundant_test()->
    ?assertEqual(true, pb23:isAbundant(12)),
    ?assertEqual(false, pb23:isAbundant(10)).

%% pb23_test_()->
%%     {
%%       timeout, 50, 
%%       fun() ->
%%     ?assertEqual(12, pb23:pb23())
%%       end
%%     }.


pb52_is_with_same_digits_test() ->
    ?assertEqual(true, pb52:is_with_same_digits("12345", "54312")),
    ?assertEqual(true, pb52:is_with_same_digits("12344", "43412")),
    ?assertEqual(true, pb52:is_with_same_digits("12345", "12345")),
    ?assertEqual(false, pb52:is_with_same_digits("12345", "543121")),
    ?assertEqual(false, pb52:is_with_same_digits("12345", "54322")).

pb52_test() ->
    ?assertEqual(142857, pb52:pb52()).


pb55_is_Lychrel_test()->
    ?assertEqual(true, pb55:is_Lychrel(10677)),
    ?assertEqual(true, pb55:is_Lychrel(4994)).
