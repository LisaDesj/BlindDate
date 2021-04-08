# BlindDate

To Tiger from Lisa:

- When creating a profile, need to write answers in ' ' except for single numbers, and type a period and then enter.
- Save an extra copy of trialDB.csv because I wrote the "write" function in read_profile and it will add a new profile to the database.
- trialDB.csv is a sample database and feel free to add or change it (but it must be formated the way it is) (Also best if the answers have only a few choices)
- we will need more wants added but it was a lot of work for me to write this already, please add if you can.

Columns: name,age,sex,orientation,bodytype,education,ethnicity,height,location,offspring,wAge,wSex,wKids

Age: don't put ' ' around integer. \
Sex: 'M', 'F', 'TM', 'TF', \
Orientation: 'straight', 'gay', 'bisexual', \
Body type: 'thin', 'average', 'athletic', 'a little extra', \
Education: 'high school', 'some college', 'college', \
Ethnicity: if more than one race choose 'mixed', \
Height: in inches, \
Location: 'Vancouver', 'Burnaby', 'Richmond', 'Surrey' \
Offspring: 'has kid(s)', 'no kids', \
wSex (wants Gender): 'M', 'F', or 'B' (both) (forgot to add options for 'TM' and 'TF'),\
wKids (wants future kids): 'yes', 'no', 'maybe', \

BrettC's code for read_profile:
https://stackoverflow.com/questions/37379782/how-to-generate-rules-from-csv-files-in-prolog
(also concerned about how his code (at bottom of read_profile) will manage a larger database).
(Could just put in rows, I guess,but thought his way would be easier)
