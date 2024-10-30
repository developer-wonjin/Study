//https://school.programmers.co.kr/learn/courses/30/lessons/72411
#include <string>
#include <vector>
#include <map>
#include <set>
#include <unordered_map>
#include <unordered_set>
#include <iostream>

using namespace std;
/*
레스토랑을 운영하던 스카피는 코로나19로 인한 불경기를 극복하고자 메뉴를 새로 구성하려고 고민하고 있습니다.
기존에는 단품으로만 제공하던 메뉴를 조합해서 코스요리 형태로 재구성해서 새로운 메뉴를 제공하기로 결정했습니다. 어떤 단품메뉴들을 조합해서 코스요리 메뉴로 구성하면 좋을 지 고민하던 "스카피"는 이전에 각 손님들이 주문할 때 가장 많이 함께 주문한 단품메뉴들을 코스요리 메뉴로 구성하기로 했습니다.
단, 코스요리 메뉴는 최소 2가지 이상의 단품메뉴로 구성하려고 합니다. 또한, 최소 2명 이상의 손님으로부터 주문된 단품메뉴 조합에 대해서만 코스요리 메뉴 후보에 포함하기로 했습니다.

예를 들어, 손님 6명이 주문한 단품메뉴들의 조합이 다음과 같다면,
(각 손님은 단품메뉴를 2개 이상 주문해야 하며, 각 단품메뉴는 A ~ Z의 알파벳 대문자로 표기합니다.)
*/

vector<char> alphaVec;

vector<string> solution(vector<string> orders, vector<int> course) {
    vector<string> answer;

    map<char, int> alphaCountMap;
    for (auto& order : orderes) {
        for (auto& ch : order) {
            alphaCountMap[ch]++;
        }
    }

    
    for (auto& entry : alphaCountMap) {
        if (entry.second < 2) continue;
        alphaVec.push_back(entry.first);
    }

    //메뉴구성 : 주문횟수
    map<set<char>, int> orderFreq;
    for (int chooseNum = 2; chooseNum < alphaVec.size(); chooseNum++) {
        int cnt = 0;



        res[chooseNum] = cnt;
    }

    return answer;
}