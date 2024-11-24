#include<vector>
#include<iostream>

using namespace std;

vector<int> myGraph[100];
int visited[100];
vector<char> ans;

void DFS (int curr) {
    ans.push_back((char)('A' + curr));
    visited[curr] = 1;

    for (int& next : myGraph[curr]) {
        if (visited[next] == 1) continue;
        DFS(next);
    }
}

vector<char> solution(vector<pair<char, char>> graph, char start) {
    for (int i = 0; i < graph.size(); i++) {
        pair<char, char>& entry = graph[i];
        myGraph[entry.first - 'A'].push_back(entry.second - 'A');
    }

    DFS(start - 'A');
    return ans;
}

int main(){ 

    const auto& result = solution(
        {{'A', 'B'}, 
        {'B', 'C'}, 
        {'C', 'D'}, 
        {'D', 'E'}}
        , 'A'
    );

    // vector<int>& result = solution(
    //     {{'A', 'B'}, 
    //     {'A', 'C'}, 
    //     {'B', 'D'}, 
    //     {'B', 'E'}, 
    //     {'C', 'F'}, 
    //     {'E', 'F'}}
    //     , 'A'
    // );

    for (auto& ele : result) cout << ele << " ";

    return 0;
}