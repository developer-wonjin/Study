// https://school.programmers.co.kr/learn/courses/30/lessons/92334

#include <string>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <sstream>
using namespace std;

/*
각 유저는 한 번에 한 명의 유저를 신고

신고 횟수에 제한X
서로 다른 유저를 계속해서 신고가능

한 유저를 여러 번 신고가능
동일한 유저에 대한 여러번의 신고는 1회

k번 이상 신고된 유저는 게시판 이용이 정지
해당 유저를 신고한 모든 유저에게 정지 사실을 메일로 발송

다음은 전체 유저 목록이 ["muzi", "frodo", "apeach", "neo"]이고,
k = 2(즉, 2번 이상 신고당하면 이용 정지)인 경우의 예시입니다.*/
vector<int> solution(vector<string> id_list, vector<string> report, int k) {
    vector<int> answer;
    unordered_map<string, unordered_set<string>> reporterMap, userMap;
    
    for (string& ele : report) {
        stringstream ss(ele);
        string reporter, user;
        ss >> reporter >> user;
        reporterMap[user].insert(reporter);
        userMap[reporter].insert(user);
    }    

    for (string& ele : id_list) {
        unordered_set<string>& userSet = userMap[ele];
        
        int cnt = 0;
        for(const string& user : userSet) {
            if (reporterMap[user].size() >= k)cnt++;
        }
        answer.push_back(cnt);
    }

    return answer;
}