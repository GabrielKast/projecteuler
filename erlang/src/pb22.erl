%%% File    : pb22.erl
%%% Author  : gabriel <gabriel@Surabaya>
%%% Description : Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.
%%% For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938  53 = 49714.
%%% What is the total of all the name scores in the file?
%%% Created : 31 Oct 2010 by gabriel <gabriel@Surabaya>

-module(pb22).
-export([pb22/0, pb22/1, getScore/2]).
pb22() ->
    %% Read names.txt file
    pb22(read_lines("../src/names.txt")).

pb22(Names)->
    SortedNames=qsort (Names),
    ListOfScores=getScores(SortedNames, []),
    lists:sum(ListOfScores).
getScores([], Scores) -> 
    lists:reverse(Scores);
getScores([Name|Tail], Scores) ->
    %% Compute score. The Nth of the Name is given by the number of Scores already collected
    NewScore=getScore(Name, length(Scores)+1),
    getScores(Tail, [NewScore | Scores]).

getScore(Name, Nth)->
    Nth * lists:foldr( 
	    fun(Elem, Sum)-> Sum + Elem  - $A + 1  end
	    , 0
	    , string:to_upper(Name)).

%% Found on wikipedia :)
qsort([]) -> []; % If the list [] is empty, return an empty list (nothing to sort)
qsort([Pivot|Rest]) -> 
    % Compose recursively a list with 'Front' for all elements that should be before 'Pivot'
    % then 'Pivot' then 'Back' for all elements that should be after 'Pivot'
    qsort([Front || Front <- Rest, Front < Pivot]) 
    ++ [Pivot] ++ 
    qsort([Back || Back <- Rest, Back >= Pivot]).
%% Found on Tim Bray's Blog
read_lines(File) ->
    {ok, Rest} = file:read_file(File),
    List = binary_to_list(Rest),
    Names = string:tokens(List, ","),
    %% remove " and create a list with all the names
    lists:map (fun(Elem)->string:strip(Elem, both, $") end, Names).
