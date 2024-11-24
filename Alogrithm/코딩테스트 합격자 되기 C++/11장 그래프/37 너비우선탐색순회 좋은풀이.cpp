#include<vector>
#include<queue>
#include<iostream>
#include<unordered_map>
#include<unordered_set>

using namespace std;

queue<char> q;
// vector<int> myGraph[100];
unordered_map<char, vector<char>> myGraph;
// unordered_map<char, int> visited;
unordered_set<char> visited;

vector<char> ans;
void BFS (char start) {
    visited.insert(start);
    q.push(start);
    
    while(q.size()) {
        char curr = q.front(); q.pop();
        ans.push_back(curr);

        for (auto& next : myGraph[curr]) {
            if (visited.find(next) != visited.end()) continue;
            visited.insert(next);
            q.push(next);
        }
    }
}

vector<char> solution(vector<pair<char, char>> graph, char start) {
    for (int i = 0; i < graph.size(); i++) {
        pair<char, char>& entry = graph[i];
        myGraph[entry.first].push_back(entry.second);
    }

    BFS(start);
    return ans;
}

int main(){ 

    // const auto& result = solution(
    //     {{'A', 'B'}, 
    //     {'B', 'C'}, 
    //     {'C', 'D'}, 
    //     {'D', 'E'}}
    //     , 'A'
    // );

    const auto& result = solution(
        {{'Z', 'A'}, 
        {'A', 'B'}, 
        {'B', 'C'}, 
        {'C', 'D'}, 
        {'D', 'E'}, 
        {'E', 'Z'}}
        , 'A'
    );

    for (auto& ele : result) cout << ele << " ";

    return 0;
}