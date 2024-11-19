#include<bits/stdc++.h>

using namespace std;
/*
     1 ------2 --------- 6
      \     / \        /   
       \   /   4 ---- 5
        \ /   / \
         3 - 7 - 8 - 9
*/

int visited[10];
vector<int> myGraph[10];
queue<int> myQ;

void BFS(int start) {

    visited[start] = 1;
    myQ.push(start);

    while (myQ.size()) {
        int curr = myQ.front(); myQ.pop();
        cout << curr << " -> ";
        for (int i = 0; i < myGraph[curr].size(); i++){
            int next = myGraph[curr][i];
            if (visited[next])continue;

            visited[next] = visited[curr] + 1;
            myQ.push(next);
        }
    }
}

int main() {

    int n, m;
    cin >> n >> m;
    for (int i = 0; i < m; i++) {
        int u,v;
        cin >> u >> v;

        myGraph[u].push_back(v);
        myGraph[v].push_back(u);
    }

    BFS(1);cout << "\n";

    for (int i = 1; i < 10; i++) {
        cout << visited[i] << " ";
    }

    return 0;
}

/*
9 12
1 2
1 3
2 3
2 4
2 6
3 7
4 5
4 7
4 8
5 6
7 8
8 9
*/