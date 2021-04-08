

% Preprocess Data to include a score

preprocess([], []).
preprocess([(H2, 0)|T1], [H2|T2]) :- preprocess(T1, T2).
