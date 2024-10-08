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

vector<int> solution(int N, vector<int> stages) {
    vector<int> answer;

    for (int& stageNum : stages){
        onStages[stageNum]++;
    }

    for (int i = N + 1; i > 0; i--){
        passStages[i] = passStages[i + 1] + onStages[i];
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