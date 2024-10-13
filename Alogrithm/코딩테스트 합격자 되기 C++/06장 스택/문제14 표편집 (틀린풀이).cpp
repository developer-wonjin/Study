#include <string>
#include <vector>
#include <list>
#include <stack>
using namespace std;

vector<string> split(string str, string delimeter) {
    vector<string> ret;

    auto s = 0;
    auto e = str.find(delimeter);

    while (e != string::npos){
        ret.push_back(str.substr(s, e-s));
        s = e + delimeter.size();
        e = str.find(delimeter, s);
    }
    ret.push_back(str.substr(s));
    return ret;
}

string solution(int n, int k, vector<string> cmds) {
    string answer = "";
    stack<pair<int, int>> history;

    list<int> v;
    // vector<pair<int, int>> v;

    for (int i = 0; i < n; i++){
        v.push_back({i});
    }

    int currSize = n;
    for (auto& cmd : cmds) {
        vector<string> splits = split(cmd, " ");
        if (splits[0] == "U") {
            k -= stoi(splits[1]);
        } else if (splits[0] == "D") {
            k += stoi(splits[1]);
        } else if (splits[0] == "C"){
            auto it = v.begin();
            advance(it, k);
            history.push({k, *it});
            v.erase(it);
            if (k == currSize -1) k--;
            currSize--;
        } else {
            int reIdx = history.top().first;
            int orginIdx = history.top().second;
            history.pop();
            auto it = v.begin();
            advance(it, reIdx);
            v.insert(it, orginIdx);
            currSize++;
            if (reIdx <= k) {
                k++;
            }
        }
    }

    int arr[1000003] = {};
    while (history.size()) {
        arr[history.top().second] = 1;
        history.pop();
    }


    for (int i = 0; i < n; i++){
        if (arr[i] == 0)answer += "O";
        else answer += "X";
    }

    return answer;
}

#include<iostream>

int main(){

    cout << solution(8, 2, 	{"D 2","C","U 3","C","D 4","C","U 2","Z","Z"}) << "\n";
    cout << solution(8, 2, 	{"D 2","C","U 3","C","D 4","C","U 2","Z","Z","U 1","C"}) << "\n";

    return 0;
}