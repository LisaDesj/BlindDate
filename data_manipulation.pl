% Give score
% match with the first elment recieve 4 points
% seoncond recieve 3 points
% third, 2 points
% fourth, 1 point
% argument: data, pref, newdata, age, loc, sex, kids

score_by_pref([], _, [], _, _, _, _).
score_by_pref([H|T], Pref, [(H, V)|T2], Age, Loc, Sex, Kids) :-
  score_helper(H, Pref, V, 0, Age, Loc, Sex, Kids),
  score_by_pref(T, Pref, T2, Age, Loc, Sex, Kids).

% score_helper()
score_helper(_, _, 0, 4, _, _, _, _).
score_helper(H, Pref, V, Ind, Age, Loc, Sex, Kids) :-
  NInd is Ind + 1,
  (check_attr(H, Pref, Ind, Age, Loc, Sex, Kids) ->
    score_helper(H, Pref, K, NInd, Age, Loc, Sex, Kids),
    V is (2 * (4 - Ind)) + K
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
score_again([], [],  _, _, _).
score_again([(H, V)| T1], [(H, Y)| T2], Age, Kids, Sex) :-
  wAge(H, HW),
  wKids(H, HK),
  wSex(H, HS),
  get_from_wage(HW, FS, SS),
  (Age >= FS,
   SS >= Age ->
    V1 = 1;
    V1 = 0),
  (HK == Kids ->
    V2 = 1;
    V2 = 0),
  (HS == "B" ->
    V3 = 1;
    HS == Sex ->
      V3 = 1;
      V3 = 0),
  Y is V + V1 + V2 + V3,
  score_again(T1, T2, Age, Kids, Sex).





% to get the lowerbond and upper bond from WAge
get_from_wage(WAge, FS, SS) :-
  split_string(WAge, "-", "", WL),
  nth0(0, WL, F),
  nth0(1, WL, S),
  atom_number(F, FS),
  atom_number(S, SS).


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

