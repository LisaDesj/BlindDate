:- [take_input].
:- [write_profile].
:- [data_manipulation].

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
        getMatches(N,A,Sex,Ori,BT,Edu,Eth,H,L,K,WAge,WSex,WKids),
        createProfile(N,A,Sex,Ori,BT,Edu,Eth,H,L,K,WAge,WSex,WKids)
        % -----------------------
        % the following line is used only for implementation and debugging
        % getMatches("Bob", 22, "M", "straight","average","some college","asian", 67,
        %             "Vancouver","no","20-40","F","maybe")
        % createProfile("Bob", 22, "M", "straight","average","some college","asian", 67,
        %             "Vancouver","no","20-40","F","maybe")
        %------------------------
        ; write("Thanks for creating your profile. Restart Blind Date to look for matches!")).


% write profile to csv
createProfile(N,A,Sex,Ori,BT,Edu,Eth,H,L,K,WAge,WSex,WKids) :-
    csv_read_file('trialDB.csv', Data),
    append(Data, [row(N,A,Sex,Ori,BT,Edu,Eth,H,L,K,WAge,WSex,WKids)],X),
    csv_write_file('trialDB.csv',X).


% getMatches takes in a profile and outputs a list of matches
getMatches(N,A,Sex,Ori,BT,Edu,Eth,H,L,K,WAge,WSex,WKids) :-
    csv_read_file("trialDB.csv", [_|Data]),
    take_pref(Pref),
    get_from_wage(WAge, FS, SS),
    % SP_Data : scored by preference data
    score_by_pref(Data, Pref, SP_Data, (FS, SS), Loc, WSex, WKids),
    % SA_Data : data score again
    score_again(SP_Data, SA_Data, A, K, Sex, WKids, WSex),
    sort(0, @>=, SA_Data, Sorted_Data),
    show_result(X, Sorted_Data).
    %------------------------
    % % Used for rating system debugging
    % print_data(Sorted_Data).
    %------------------------
    

% lookingFor parses the database for a specific attribute and 
% returns the names of people who have that attribute

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
