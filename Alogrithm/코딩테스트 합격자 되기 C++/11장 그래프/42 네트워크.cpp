// https://school.programmers.co.kr/learn/courses/30/lessons/43162

#include <string>
#include <vector>
#include <iostream>

using namespace std;

int visited[201];

void f (int curr, vector<vector<int>>& computers) {
    cout << curr << " ";
    visited[curr] = 1;

    for (int next = 0; next < computers[curr].size(); next++) {
        if (computers[curr][next] == 0) continue;
        if (visited[next] > 0) continue;
        f (next, computers);
    }
}

int solution(int n, vector<vector<int>> computers) {
    int answer = 0;

    for (int i = 0; i < n; i++) {
        if (visited[i]) continue;

        answer++;
        f (i, computers);
    }
    
    return answer;
}