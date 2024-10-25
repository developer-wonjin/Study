// https://school.programmers.co.kr/learn/courses/30/lessons/42888
#include <string>
#include <vector>
#include <unordered_map>
#include <iostream>

using namespace std;

vector<string> split(string& str, string delimeter) {
    vector<string> ret;

    int s = 0;
    int e = str.find(delimeter);

    while (e != string::npos) {
        ret.push_back(str.substr(s, e - s));
        s = e + delimeter.size();
        e = str.find(delimeter, s);
    }
    ret.push_back(str.substr(s));
    return ret;
}

vector<string> solution(vector<string> records) {
    vector<string> answer;

    unordered_map<string, string> mentionMap = {
        {"Enter", "님이 들어왔습니다."},
        {"Leave", "님이 나갔습니다."}
    };

    unordered_map<string, string> nicknameMap;
    vector<pair<string, string>> historyVector;


    for (string& record : records) {
        vector<string> splits = split(record, " ");
        string cmd = splits[0];
        // cout << cmd << "\n";
        if (cmd == "Enter") {
            string id = splits[1];
            string nickname = splits[2];
            nicknameMap[id] = nickname;
            historyVector.push_back({id, cmd});
        } else if (cmd == "Change") {
            string id = splits[1];
            string nickname = splits[2];
            nicknameMap[id] = nickname;
        } else {
            string id = splits[1];
            historyVector.push_back({id, cmd});
        }
    }

    for (auto& history : historyVector) {
        string id = history.first;
        string cmd = history.second;
        answer.push_back(nicknameMap[id] + mentionMap[cmd]);
    }

    return answer;
}

int main () {
    vector<string> ret = solution({
        "Enter uid1234 Muzi", 
        "Enter uid4567 Prodo",
        "Leave uid1234",
        "Enter uid1234 Prodo",
        "Change uid4567 Ryan"
    });
    for (auto ele : ret) cout << ele << " ";

    return 0;
}