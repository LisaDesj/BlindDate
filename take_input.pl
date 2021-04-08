% helper functions for read_profile to take inputs
% checks if input is valid


take_name(N) :- 
  check_string(N,
              "Create a profile by first writing your name. Example \"Lisa\". ",
              "Name needs to be a string.").

take_age(A) :-
  check_int(A,
            "How old are you? Example 25. ",
            "Age needs to be an integer, try again.").

take_sex(Sex) :-
  check_valid(Sex,
              ["M", "F", "TM", "TF"],
              "Type your gender: \"M\", \"F\", \"TM\", \"TF\". ",
              "Sorry, your gender isn't supported by this program for now").

take_Ori(Ori) :-
  check_valid(Ori,
              ["straight", "gay", "bisexual"],
              "What is your orientation: \"straight\", \"gay\", or \"bisexual\". ",
              "Sorry, your orientation isn't supported by this program for now").

take_BT(BT) :-
  check_valid(BT,
              ["thin", "average", "athletic", "a little extra"],
              "Describe your body type: \"thin\", \"average\", \"athletic\", \"a little extra\". ",
              "Sorry your body type isn't supported by this program for now").

take_Edu(Edu) :-
  check_valid(Edu,
              ["high school", "some college", "college"],
              "Type your level of education: \"high school\", \"some college\", \"college\". ",
              "Please choose an option that's closest to your situation").

take_Eth(Eth) :-
  check_string(Eth,
              "What is your ethnicity? Example \"caucasian\", \"mixed\"...",
              "Ethnicity needs to be a string.").

take_height(H) :-
  check_int(H,
            "What is your height in inches? Example 70. ",
            "Age needs to be an integer, try again.").

take_loc(L) :-
  check_string(L,
              "Where are you located? Example \"Vancouver\". ",
              "Location needs to be a string").

take_kids(K) :-
  check_valid(K, ["yes", "no"],
              "Do you have kids? \"yes\" or \"no\". ",
              "Please choose a provided option").
take_WAge(WAge) :-
  write("What age range are you looking for? Example \"18-25\". "),
  nl,
  read(WAge).

take_WSex(WSex) :-
  check_valid(WSex,
              ["M", "F", "B"],
              "Are you looking for a man (type \"M\") a woman (type \"F\") or both (type \"B\"). ",
              "Please choose a provided option").

take_WKids(WKids) :-
  check_valid(WKids,
              ["yes", "no", "maybe"],
              "Lastly do you want any future kids? \"yes\", \"no\" or \"maybe\". ",
              "please choose a provided option").

take_ready(Answer) :-
  check_valid(Answer,
              ["Y", "N"],
              "Are you ready to look for matches? \"Y\" or \"N\".
               Your profile will not be saved if you choose \"N\"",
              "Please choose an valid option").

take_pref(Pref) :-
  write("Input your preference of attributes (Sex, Kids, Loc, Age) in an ordered list.
        Example #1: [\"Sex\", \"Kids\", \"Loc\", \"Age\"]
        Example #2: [\"Loc\", \"Age\", \"Sex\", \"Kids\"]"),
  nl,
  read(P2),
  (permutation(P2, [Sex, Kids, Loc, Age]) ->
    Pref = P2
    ;
    write("Input invalid, try again."),
    nl,
    take_pref(Pref)).
  

check_valid(X, Lis, Mes, ErrM) :-
  write(Mes),
  nl,
  read(Y),
  (member(Y, Lis) ->
    X = Y
    ;
    write(ErrM),
    nl,
    check_valid(X, Lis, Mes, ErrM)).

check_string(X, Mes, ErrM) :-
  write(Mes),
  nl,
  read(Y),
  (string(Y) ->
    X = Y
    ;
    write(ErrM),
    nl,
    check_string(X, Mes, ErrM)).

check_int(X, Mes, ErrM) :-
  write(Mes),
  nl,
  read(Y),
  (integer(Y) ->
    X = Y
    ;
    write(ErrM),
    nl,
    check_int(X, Mes, ErrM)).


  