:- [take_input].
:- [write_profile].

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
    % not sure how we will handle age range
    take_WAge(WAge),
    take_WSex(WSex),
    take_WKids(WKids),
    take_ready(Answer),
    (Answer == "Y" -> 
        getMatches(N,A,Sex,Ori,BT,Edu,Eth,H,L,K,WAge,WSex,WKids),
        createProfile(N,A,Sex,Ori,BT,Edu,Eth,H,L,K,WAge,WSex,WKids)
        ; write('Thanks for creating your profile. Restart Blind Date to look for matches!')).


% write profile to csv
createProfile(N,A,Sex,Ori,BT,Edu,Eth,H,L,K,WAge,WSex,WKids) :-
    csv_read_file('trialDB.csv', Data),
    append(Data, [row(N,A,Sex,Ori,BT,Edu,Eth,H,L,K,WAge,WSex,WKids)],X),
    csv_write_file('trialDB.csv',X).


% getMatches takes in a profile and outputs a list of matches
getMatches(N,A,Sex,Ori,BT,Edu,Eth,H,L,K,WAge,WSex,WKids) :-
     write('Work In Progress!').

% lookingFor parses the database for a specific attribute and returns the names of people who have that attribute