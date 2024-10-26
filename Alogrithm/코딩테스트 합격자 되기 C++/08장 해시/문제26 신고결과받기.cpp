#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <sstream>
using namespace std;

// 이 함수는 신고 처리 로직을 담고 있습니다.
vector<int> solution(vector<string> id_list, vector<string> report, int k) {
    vector<int> answer(id_list.size(), 0);
    unordered_map<string, unordered_set<string>> reporterMap, userMap;

    for (string& ele : report) {
        stringstream ss(ele);
        string reporter, user;
        ss >> reporter >> user;
        reporterMap[user].insert(reporter);
        userMap[reporter].insert(user);
    }

    for (auto ele : id_list) {
        const unordered_set<string>& userSet = userMap[ele];
        int cnt = 0;
        for (auto user : userSet) {
            if (reporterMap[user].size() >= k) cnt++;
        }
        answer.push_back(cnt);
    }

    return answer;
}

// 콘솔 프로그램의 진입점
int main() {
    // 여기에 테스트 코드 추가 가능
    vector<string> id_list = {"muzi", "frodo", "apeach", "neo"};
    vector<string> report = {"muzi frodo", "apeach frodo", "frodo neo", "muzi neo", "apeach muzi"};
    int k = 2;
    
    vector<int> result = solution(id_list, report, k);
    
    for (int count : result) {
        cout << count << " ";
    }
    cout << endl;

    return 0;
}
