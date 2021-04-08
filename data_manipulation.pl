

% Preprocess Data to include a score

preprocess([], []).
preprocess([(H2, 0)|T1], [H2|T2]) :- preprocess(T1, T2).


% Give score
% match with the first elment recieve 4 points
% seoncond recieve 3 points
% third, 2 points
% fourth, 1 point
% argument: data, pref, newdata, age, loc, sex, kids

score_by_pref([], _, _, _, _, _, _).
score_by_pref([H|T], Pref, [(H, V)|T2], Age, Loc, Sex, Kids) :-
  score_helper(H, Pref, V, 0, Age, Loc, Sex, Kids),
  score_by_pref(T, Pref, T2, Age, Loc, Sex, Kids).

% score_helper()
score_helper(_, _, 0, 4, _, _, _, _).
score_helper(H, Pref, V, Ind, Age, Loc, Sex, Kids) :-
  NInd is Ind + 1,
  (check_attr(H, Pref, Ind, Age, Loc, Sex, Kids) ->
    score_helper(H, Pref, K, NInd, Age, Loc, Sex, Kids),
    T is 4 - Ind,
    V is T + K
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

