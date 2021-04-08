# include <bits/stdc++.h>

using namespace std;

int main() {

  ifstream db ("trialDB_deprecated.csv");
  ofstream newdb ("trialDB.csv");
  string line;
  string nline;
  vector<string> v;
  string word;
  while(getline(db, line)) {
    v.clear();
    word = "";
    for (int i = 0; i < line.size(); i++) {
      if (line[i] != ',') {
        word += line[i];
        continue;
      }
      v.push_back(word);
      word = "";
    }
    v.push_back(word);
    nline = "";
    for (int i = 0; i < v.size(); i++) {
      if (i > 0) nline += ',';
      if (v[i] == "has kid(s)") {
        nline += "yes";
      } else if (v[i] == "no kids") {
        nline += "no";
      } else {
        nline += v[i];
      }
    }
    newdb << nline << '\n';
  }
  newdb.close();

  return 0;
}