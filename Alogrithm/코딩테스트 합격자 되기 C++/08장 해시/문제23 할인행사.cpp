// https://school.programmers.co.kr/learn/courses/30/lessons/131127
#include <string>
#include <vector>
#include <unordered_map>
#include <iostream>
using namespace std;

unordered_map<string, int> wantMap, discountMap;

void printMap(unordered_map<string, int>& map) {
    for (auto& ele : map) {
        cout << ele.first << ": " << ele.second << " ";
    }
    cout << "\n";
}

int solution(vector<string> want, vector<int> number, vector<string> discount) {
    int answer = 0;

    for (int i = 0; i < want.size(); i++) {
        wantMap[want[i]] = number[i];
    }

    // 초기 10개만 집계
    for (int i = 0; i < 10; i++) {
        discountMap[discount[i]]++;
    }
    // printMap(discountMap);
    if (wantMap == discountMap)answer++;

    // 끝점을 이동한다.
    for (int i = 10; i < discount.size(); i++) {
        // 끝점 추가
        discountMap[discount[i]]++;
        // 시작점 제거
        discountMap[discount[i-10]]--;

        // 예외처리 생각지도 못함;;
        if (discountMap[discount[i-10]] == 0) {
            discountMap.erase(discount[i-10]);
        }
        // printMap(discountMap);

        if (wantMap == discountMap)answer++;
    }

    // printMap(wantMap);

    return answer;
}
