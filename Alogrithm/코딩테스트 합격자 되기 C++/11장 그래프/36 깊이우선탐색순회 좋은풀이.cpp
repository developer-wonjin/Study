#include<vector>
#include<iostream>
#include<unordered_map>
#include<unordered_set>

using namespace std;

// vector<int> myGraph[100];
unordered_map<char, vector<char>> myGraph;
// unordered_map<char, int> visited;
unordered_set<char> visited;

vector<char> ans;

void DFS (char curr) {
    ans.push_back(curr);
    visited.insert(curr);

    for (char& next : myGraph[curr]) {
        if (visited.find(next) != visited.end()) continue;
        DFS(next);
    }
}

vector<char> solution(vector<pair<char, char>> graph, char start) {
    for (int i = 0; i < graph.size(); i++) {
        pair<char, char>& entry = graph[i];
        myGraph[entry.first].push_back(entry.second);
    }

    DFS(start);
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
        {{'A', 'B'}, 
        {'A', 'C'}, 
        {'B', 'D'}, 
        {'B', 'E'}, 
        {'C', 'F'}, 
        {'E', 'F'}}
        , 'A'
    );

    for (auto& ele : result) cout << ele << " ";

    return 0;
}