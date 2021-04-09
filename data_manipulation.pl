% Give score
% match with the first elment recieve 4 points
% seoncond recieve 3 points
% third, 2 points
% fourth, 1 point
% argument: data, pref, newdata, age, loc, sex, kids

score_by_pref([], _, [], _, _, _, _).
score_by_pref([H|T], Pref, [V-H|T2], Age, Loc, Sex, Kids) :-
  score_helper(H, Pref, V, 0, Age, Loc, Sex, Kids),
  score_by_pref(T, Pref, T2, Age, Loc, Sex, Kids).

% score_helper()
score_helper(_, _, 0, 4, _, _, _, _).
score_helper(H, Pref, V, Ind, Age, Loc, Sex, Kids) :-
  NInd is Ind + 1,
  (check_attr(H, Pref, Ind, Age, Loc, Sex, Kids) ->
    score_helper(H, Pref, K, NInd, Age, Loc, Sex, Kids),
    V is (1 * (10 - Ind)) + K
    ;
    score_helper(H, Pref, V, NInd, Age, Loc, Sex, Kids)).



check_attr(H, Pref, Ind, (FS, SS), Loc, Sex, Kids) :-
  nth0(Ind, Pref, Attr),
  (Attr == "Loc" -> loc(H, Loc);
  Attr == "Sex" -> sex(H, Sex);
  Attr == "Kids" -> kids(H, Kids);
    age(H, A2),
    A2 >= FS,
    SS >= A2).


% this score adds to the current score
% for each criterial that the user satisfies, add 1
% NOTE: "maybe" in having kids is treated as neither (no points awards either way)
% NOTE: "B" in want gender is reated as both (points awarded either way)
score_again([], [],  _, _, _, _, _).
score_again([V-H| T1], [Y-H| T2], Age, Kids, Sex, Wk, Ws) :-
  wAge(H, HW),
  wSex(H, HS),
  get_from_wage(HW, FS, SS),
  (Age >= FS,
   SS >= Age ->
    V1 is 2;
    V1 is -1),
  (wKids(H, Kids) ->
    (kids(H, Wk) -> V2 is 5; V2 is 2);
    V2 is -1),
  (atom_string(HS, "B") ->
    (sex(H, Ws) -> V3 is 5 ; V3 is 2);
    wSex(H, Sex) ->
      (sex(H, Ws) -> V3 is 5; V3 is 2);
      V3 is -3),
  % blob(HS, TT),
  % % (string(HS) -> write("HS is string \n"); write("Not string \n")),
  % write(TT), nl,
  Y is V + V1 + V2 + V3,
  score_again(T1, T2, Age, Kids, Sex, Wk, Ws).

% to get the lowerbond and upper bond from WAge
get_from_wage(WAge, FS, SS) :-
  split_string(WAge, "-", "", WL),
  nth0(0, WL, F),
  nth0(1, WL, S),
  atom_number(F, FS),
  atom_number(S, SS).

% Sort data based on score
% sort_data((H, )) 


% debug tool
% print data
print_data([]).
print_data([H|T]) :-
  write(H),
  nl,
  print_data(T).

% Following are predicates used to access elements easily
first((X, _), X).
second((_, X), X).
% name,age,sex,orientation,bodytype,education,ethnicity,height,location,offspring,wAge,wSex,wKids
name(row(X,_,_,_,_,_,_,_,_,_,_,_,_), X).
age(row(_,X,_,_,_,_,_,_,_,_,_,_,_), X).
sex(row(_,_,X,_,_,_,_,_,_,_,_,_,_), X).
ori(row(_,_,_,X,_,_,_,_,_,_,_,_,_), X).
bt(row(_,_,_,_,X,_,_,_,_,_,_,_,_), X).
edu(row(_,_,_,_,_,X,_,_,_,_,_,_,_), X).
eth(row(_,_,_,_,_,_,X,_,_,_,_,_,_), X).
height(row(_,_,_,_,_,_,_,X,_,_,_,_,_), X).
loc(row(_,_,_,_,_,_,_,_,X,_,_,_,_), X).
kids(row(_,_,_,_,_,_,_,_,_,X,_,_,_), X).
wAge(row(_,_,_,_,_,_,_,_,_,_,X,_,_), X).
wSex(row(_,_,_,_,_,_,_,_,_,_,_,X,_), X).
wKids(row(_,_,_,_,_,_,_,_,_,_,_,_,X), X).

