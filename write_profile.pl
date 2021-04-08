% Code Below makes FACTS from data in trialDB.csv
% Code Below: Author BretC 
% https://stackoverflow.com/questions/37379782/how-to-generate-rules-from-csv-files-in-prolog

% Exmaple clause to read a file and print out facts to the console.
% Instead of printing, you could do whatever you like with them (assert them into WM for example)
example :-
    build_facts_from_file('trialDB.csv', FACTS),
    writeln(FACTS). % can comment this line out later

% build_facts_from_file(FILENAME_IN, FACTS_OUT).
% Reads the file and outputs a list of facts.
build_facts_from_file(FILENAME, FACTS) :-
    open(FILENAME, read,S),
    read_csv(S,[HEADER | PROFILES]),
    close(S),
    build_profiles(HEADER, PROFILES, FACTS).

% read_csv(INPUT_STREAM_IN, LINES_OUT)
% Read comma-seperated values from the stream S into a list (one element per line)
read_csv(S, []) :-
    % Stop if EOF
    at_end_of_stream(S), !.

read_csv(S, [L | T]) :-
    % Read whole line as character codes
    read_line_to_codes(S, CODES),
    % Translate the line into a list of atoms
    translate_csv(CODES, [], L),
    % Read the other lines
    read_csv(S, T).

% translate(CHARACTER_CODE_LIST_IN, ATOM_SO_FAR_IN, ATOMS_OUT).
% Gets a line, splits it on COMMA characters and turns each element into an atom
translate_csv([], [], []) :- !. 
    % Stopping condition when comma was at end of line, but no extra element  
translate_csv([], ATOM_CHARS, [ATOM]) :-
    % Stopping condition when non-comma was at end of line, 
    % turn list of codes for the atom found so far into an atom
    atom_chars(ATOM, ATOM_CHARS).
translate_csv([44 | CODES], ATOM_CHARS, [ATOM | ATOMS]) :- !,
    % Comma found, turn ATOM_CHARS into ATOM and start building the next atom
    atom_chars(ATOM, ATOM_CHARS),
    translate_csv(CODES, [], ATOMS).
translate_csv([CODE | CODES], ATOM_CHARS, ATOMS) :- !,  
    % Non-comma character found, appent CODE to the end of ATOM_CHARS and keep going
    append(ATOM_CHARS, [CODE], TMP_ATOM_CHARS),
    translate_csv(CODES, TMP_ATOM_CHARS, ATOMS).

% build_profiles(HEADER_IN, PROFILES_IN, FACTS_OUT)
% Process each element in PROFILES_IN to create FACTS_OUT
build_profiles(_, [], []).
    % Stopping case, no profiles left to build
build_profiles(HEADER, [PROFILE | PROFILES], FACTS) :-
    % Build facts for all the other profiles
    build_profiles(HEADER, PROFILES, FTMP1),
    % Build facts for this profile
    build_fact(HEADER, PROFILE, FTMP2),
    % Add lists together
    append(FTMP1, FTMP2, FACTS).

% build_fact(HEADER_IN, ATTRIBUTES_IN, FACTS_OUT)   
% Builds clauses for each attribute - strips out the object ID (assumed to be first attribute)
% and calls build_fact/4 to do the work
build_fact([_ | HEADER], [ID | ATTRIBUTES], FACTS) :-
    build_fact(ID, HEADER, ATTRIBUTES, FACTS).

% build_fact(OBJECT_ID_IN, PROPERTY_NAMES_IN, VALUES_IN, FACTS_OUT) 
build_fact(ID, [PROP | PROPS], [VALUE | VALUES], [FACT | FACTS]) :-
    % create term for the fact
    FACT =.. [PROP, ID, VALUE],
    % build the rest
    build_fact(ID, PROPS, VALUES, FACTS).

build_fact(_, [], [], []).
    % Stopping condition