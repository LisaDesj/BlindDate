:- [take_input].
:- [data_manipulation].
%:- [sortBySex].

% start takes in User Input to create a Blind Date profile and possibly look for matches
% type period and enter after the answer (when the user writes)
% user needs to write words encased in ' '.

start :- 
    write("Welcome to Blind Date."), nl,
    take_name(N),
    take_age(A),
    take_sex(Sex),
    take_Ori(Ori),
    take_BT(BT),
    take_Edu(Edu),
    take_Eth(Eth),
    take_height(H),
    take_loc(L),
    take_kids(K),
    take_WAge(WAge),
    take_WSex(WSex),
    take_WKids(WKids),
    take_ready(Answer),
    (Answer == "Y" -> 
        getMatches(A,Sex,L,K,WAge,WSex,WKids),
        createProfile(N,A,Sex,Ori,BT,Edu,Eth,H,L,K,WAge,WSex,WKids)
        ; write("Thanks for trying Blind Date. Restart Blind Date to look for matches!")).

% write profile to csv
createProfile(N,A,Sex,Ori,BT,Edu,Eth,H,L,K,WAge,WSex,WKids) :-
    csv_read_file('trialDB02.csv', Data),
    append(Data, [row(N,A,Sex,Ori,BT,Edu,Eth,H,L,K,WAge,WSex,WKids)],X),
    csv_write_file('trialDB02.csv',X).

% getMatches takes in a profile and outputs a list of matches
getMatches(A,Sex,L,K,WAge,WSex,WKids) :-
    csv_read_file("trialDB02.csv", [_|Data]),
    wSex3(Data,Sex,WSex,V),
    %write(Sex),
    %write(V),
    take_pref(Pref),
    get_from_wage(WAge, FS, SS),
    % SP_Data : scored by preference data
    score_by_pref(V, Pref, SP_Data, (FS, SS), L, WKids),
    % SA_Data : data score again
    score_again(SP_Data, SA_Data, A, K, WKids),
    sort(0, @>=, SA_Data, Sorted_Data),
    show_result(X, Sorted_Data).
    %------------------------
    % % Used for rating system debugging
     %print_data(Sorted_Data).
    %------------------------

% to get index of match to view
show_result(X, Sorted_Data) :-
  write("
        To view one of your top 10 matches, enter a integer in the range [1,10].
        To exit, enter \"quit\"."),
  nl,
  read(Y),
  (Y == "quit" ->
    X = Y;
    (integer(Y),
    Y >= 1,
    10 >= Y ->
        Ind is Y - 1,
        nth0(Ind, Sorted_Data, Profile),
        first(Profile, Score),
        second(Profile, Info),
        % name(Info, Name),
        % age(Info Age),
        % sex(Info, Sex),
        % bt(Info, BT),
        % edu(Info, Edu),
        % eth(Info, Eth),
        % height(Info, H),
        % loc(Info, Loc),
        % kids(Info, Kids),
        % write(Profile),
        write("\n \n ------------------------------------- \n"),
        write("Score "), write(Score),
        nl,
        write("Profile "), write(Info),
        write("\n ------------------------------------- \n \n");
    write("Invalid input, try again. \n")),
    show_result(X, Sorted_Data)).

%wSex3 parses 'trialDB02.csv' for a list of matches based on Sex and wSex.

wSex3([row(X,A,'m',O,BT,ED,ET,H,L,K,WA,"b",WK)],_,"b",[row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'b',WK)]).
wSex3([row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'b',WK)],_,"b",[row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'b',WK)]).
wSex3([row(X,A,'m',O,BT,ED,ET,H,L,K,WA,Sex,WK)],Sex,"b",[row(X,A,'m',O,BT,ED,ET,H,L,K,WA,Sex,WK)]).
wSex3([row(X,A,'f',O,BT,ED,ET,H,L,K,WA,Sex,WK)],Sex,"b",[row(X,A,'f',O,BT,ED,ET,H,L,K,WA,Sex,WK)]).
wSex3([row(_,_,AS,_,_,_,_,_,_,_,_,BS,_)],Sex,WSex,[]) :- dif(AS,WSex),dif(BS,Sex),dif(Sex,WSex).                             %dif(WSex,b).
wSex3([row(_,_,'m',_,_,_,_,_,_,_,_,_,_)],"f","f",[]). 
wSex3([row(_,_,'f',_,_,_,_,_,_,_,_,_,_)],"m","m",[]).
wSex3([row(_,_,'f',_,_,_,_,_,_,_,_,'m',_)],"f","f",[]).  
wSex3([row(_,_,'m',_,_,_,_,_,_,_,_,'f',_)],"m","m",[]). 
wSex3([row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'m',WK)],"m","f",[row(X,A,"m",O,BT,ED,ET,H,L,K,WA,"f",WK)]).
wSex3([row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'f',WK)],"f","m",[row(X,A,"m",O,BT,ED,ET,H,L,K,WA,"f",WK)]).
wSex3([row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'f',WK)],"f","f",[row(X,A,"f",O,BT,ED,ET,H,L,K,WA,"f",WK)]).
wSex3([row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'f',WK)],"f","f",[row(X,A,"f",O,BT,ED,ET,H,L,K,WA,"b",WK)]).
wSex3([row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'m',WK)],"m","m",[row(X,A,"m",O,BT,ED,ET,H,L,K,WA,"m",WK)]).
wSex3([row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'b',WK)],"m","m",[row(X,A,"m",O,BT,ED,ET,H,L,K,WA,"m",WK)]).
wSex3([row(X,A,WSex,O,BT,ED,ET,H,L,K,WA,Sex,WK)],Sex,WSex,[row(X,A,WSex,O,BT,ED,ET,H,L,K,WA,Sex,WK)]).


wSex3([row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'b',WK)|T],Sex,"b",[row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'b',WK)|V]) :- 
    wSex3(T,Sex,"b",V),!.
wSex3([row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'b',WK)|T],Sex,"b",[row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'b',WK)|V]) :- 
    wSex3(T,Sex,"b",V),!.
wSex3([row(X,A,'f',O,BT,ED,ET,H,L,K,WA,"f",WK)|T],"f","b",[row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'f',WK)|V]) :- 
    wSex3(T,"f","b",V),!.
wSex3([row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'f',WK)|T],"f","b",[row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'f',WK)|V]) :- 
    wSex3(T,"f","b",V),!.
wSex3([row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'m',WK)|T],"m","b",[row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'m',WK)|V]) :- 
    wSex3(T,"m","b",V),!.
wSex3([row(X,A,'f',O,BT,ED,ET,H,L,K,WA,m,WK)|T],"m","b",[row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'m',WK)|V]) :- 
    wSex3(T,"m","b",V),!.
wSex3([row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'m',WK)|T],"m","f",[row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'m',WK)|V]) :- 
    wSex3(T,"m","f",V),!.
wSex3([row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'f',WK)|T],"f","m",[row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'f',WK)|V]) :- 
    wSex3(T,"f","m",V),!.
wSex3([row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'m',WK)|T],"m","m",[row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'m',WK)|V]) :- 
    wSex3(T,"m","m",V),!.
wSex3([row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'b',WK)|T],"m","m",[row(X,A,'m',O,BT,ED,ET,H,L,K,WA,'b',WK)|V]) :- 
    wSex3(T,"m","m",V),!.
wSex3([row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'f',WK)|T],"f","f",[row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'f',WK)|V]) :- 
    wSex3(T,"f","f",V),!.
wSex3([row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'b',WK)|T],"f","f",[row(X,A,'f',O,BT,ED,ET,H,L,K,WA,'b',WK)|V]) :- 
    wSex3(T,"f","f",V),!.
wSex3([row(X,A,WSex,O,BT,ED,ET,H,L,K,WA,Sex,WK)|T],Sex,WSex,[row(X,A,WSex,O,BT,ED,ET,H,L,K,WA,Sex,WK)|V]) :- 
    wSex3(T,Sex,WSex,V),!.
wSex3([row(X,A,Sex,O,BT,ED,ET,H,L,K,WA,Sex,WK)|T],Sex,Sex,[row(X,A,Sex,O,BT,ED,ET,H,L,K,WA,Sex,WK)|V]) :- 
    wSex3(T,Sex,Sex,V),!.
wSex3([_|T],Sex,'b',X) :- wSex3(T,Sex,"b",X).
wSex3([_|T],Sex,WSex,X) :- wSex3(T,Sex,WSex,X).

