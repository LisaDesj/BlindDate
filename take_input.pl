% helper functions for read_profile to take inputs
% checks if input is valid


take_name(N) :- 
  write("Create a profile by first writing your name. Example 'Lisa'. "),
  nl,
  read(N).

take_age(A) :-
  write("How old are you? Example 25. "),
  nl,
  read(A).

take_sex(Sex) :-
  write("Type your gender: 'M', 'F', 'TM', 'TF'. "),
  nl,
  read(Sex).

take_Ori(Ori) :-
  write("What is your orientation: 'straight', 'gay', or 'bisexual'. "),
  nl,
  read(Ori).

take_BT(BT) :-
  write("Describe your body type: 'thin', 'average', 'athletic', 'a little extra'. "),
  nl,
  read(BT).

take_Edu(Edu) :-
  write("Type your level of education: 'high school', 'some college', 'college'. "),
  nl,
  read(Edu).

take_Eth(Eth) :-
  write("What is your ethnicity? Example 'caucasian', 'mixed'..."),
  nl,
  read(Eth).

take_height(H) :-
  write("What is your height in inches? Example 70. "),
  nl,
  read(H).

take_loc(L) :-
  write("Where are you located? Example 'Vancouver'. "),
  nl,
  read(L).

take_kids(K) :-
  write("Do you have kids? 'yes' or 'no'. "),
  nl,
  read(K).

take_WAge(WAge) :-
  write("What age range are you looking for? Example '18-25'. "),
  nl,
  read(WAge).

take_WSex(WSex) :-
  write("Are you looking for a man (type 'M') a woman (type 'F') or both (type 'B'). "),
  nl,
  read(WSex).

take_WKids(WKids) :-
  write("Lastly do you want any future kids? 'yes', 'no' or 'maybe'. "),
  nl,
  read(WKids).