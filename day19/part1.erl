-module(part1).
-export([part1/0]).

read_file(File) ->
    case file:read_line(File) of
        eof -> "";
        {ok, Data} -> [Data|read_file(File)]
    end.

make_rule(String) ->
    [Number, Rule] = string:split(String, ": "),
    {list_to_integer(Number),
     lists:map(fun(Y) -> lists:map(fun(Z) -> case string:to_integer(Z) of
                                             {error, _} -> Z;
                                             {Int, _} -> Int
                                             end end,
                                   string:split(Y, " ", all)) end,
               string:split(Rule, " | "))}.

rule_to_regex([["\"a\""]], _) ->
    "a";
rule_to_regex([["\"b\""]], _) ->
    "b";
rule_to_regex([Option1, Option2], Rules) ->
    rule_to_regex([Option1], Rules) ++ "|" ++ rule_to_regex([Option2], Rules);
rule_to_regex([Numbers], Rules) ->
    lists:concat(lists:map(fun(Number) -> #{Number := Rule} = Rules, "(" ++ rule_to_regex(Rule, Rules) ++ ")" end, Numbers)).

part1() ->
    {ok, Input} = file:open("input.txt", read),
    [RawRules, RawData] = string:split(read_file(Input), "\n\n"),
    Rules = maps:from_list(lists:map(fun(X) -> make_rule(X) end, string:split(RawRules, "\n", all))),
    Data = string:split(RawData, "\n", all),
    #{0 := ZeroRule} = Rules,
    {ok, ZeroRegex} = re:compile("^" ++ rule_to_regex(ZeroRule, Rules) ++ "$"),
    Matches = lists:filter(fun(Message) -> case re:run(Message, ZeroRegex) of
                                           {match, _} -> true;
                                           nomatch -> false
                                           end end,
                           Data),
    io:format("~p~n", [length(Matches)]).
