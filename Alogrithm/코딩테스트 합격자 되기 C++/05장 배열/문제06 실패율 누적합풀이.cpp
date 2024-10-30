//https://school.programmers.co.kr/learn/courses/30/lessons/42889


#include <vector>
#include <algorithm>
#include <iostream>

using namespace std;
const int N = 500;
int onStages[N+3] = {};
int passStages[N+3] = {};
double rate[N+3] = {};

bool cmp (pair<int, double>& a, pair<int, double>& b){
    if (a.second == b.second){
        return a.first < b.first;
    }
    return a.second > b.second;
}

/*
N     : 5
stages: [2, 1, 2, 6, 2, 4, 3, 3] 



스테이지NO 0   1   2   3   4   5   6   7
remain   [X   1   3   2   1   0   1           : 스테이지에 도달했으나 클리어하지 못한 플레이어수 집계
reached  [X   8   7   4   2   1   1   0]      : 스테이지에 도달한 플레이어수 집계


*/


vector<int> solution(int N, vector<int> stages) {
    vector<int> answer;

    for (int& stageNum : stages){
        onStages[stageNum]++;
    }

    for (int i = N + 1; i > 0; i--){
        passStages[i] = passStages[i + 1] + onStages[i]; // O(1)
    }

    vector<pair<int, double>> v;
    for (int stageNo = 1; stageNo <= N; stageNo++){
        double rate = passStages[stageNo] == 0 ? 0.0 : (double) onStages[stageNo] / passStages[stageNo];
        v.push_back({stageNo, rate});
    }

    sort(v.begin(), v.end(), cmp);

    for (auto& entry : v){
        answer.push_back(entry.first);
    }

    return answer;
}