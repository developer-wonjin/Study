#include<bits/stdc++.h>

using namespace std;
const int MAX = 100;
int visited[MAX];
vector<int> myGraph[MAX];
vector<int> ans;

// 재귀방식 : 방문했던 안했던간에 일단 DFS부터 진행해
void DFS1 (int curr) {
    // 방문했던 안했던간에 DFS로 진입한다는 전제가 깔린 구현
    
    //방문한 노드라면
    if (visited[curr]) {
        return;
    }
    
    //방문한적 없는 노드라면
    visited[curr] = 1;
    cout << curr << " -> ";

    for (int i = 0; i < myGraph[curr].size(); i++) {
        int next = myGraph[curr][i];

        DFS1(next);
    }
}

// 완전탐색방식(추천) : 방문안했던 곳만 방문한다 (방문한 곳은 또 진입하지 않는다)
void DFS2 (int curr) {
    // 방문 안했던 new노드만 DFS로 진입한다는 전제가 깔린 구현

    ans.push_back(curr);
    visited[curr] = 1;
    cout << curr << " -> ";

    for (int i = 0; i < myGraph[curr].size(); i++) {
        int next = myGraph[curr][i];
        if (visited[next])continue;

        DFS2(next);
    }
}

// 완전탐색방식(가끔)
// visited[curr] = 1; 메소드호출전 필요함
void DFS3 (int curr) {
    // 방문 안했던 new노드만 DFS로 진입한다는 전제가 깔린 구현
    cout << curr << " -> ";

    for (int i = 0; i < myGraph[curr].size(); i++) {
        int next = myGraph[curr][i];
        if (visited[next])continue;

        visited[next] = 1;//visited[curr] + 1;
        DFS3(next);
    }
}

/*
     1 ------2 --------- 6
      \     / \        /   
       \   /   4 ---- 5
        \ /   / \
         3 - 7 - 8 - 9
    
    1 -> 2 -> 3 -> 7 -> 4 -> 5 -> 6 -> 8 -> 9
*/
int main() {

    int n, m;
    cin >> n >> m;
    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        myGraph[a].push_back(b);
        myGraph[b].push_back(a);
    }

    DFS1(1);cout << "\n";
    fill(visited, visited+10, 0);
    
    DFS2(1);cout << "\n";
    fill(visited, visited+10, 0);
    
    visited[1] = 1;
    DFS3(1);cout << "\n";
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

1 -> 2 -> 3 -> 7 -> 4 -> 5 -> 6 -> 8 -> 9
*/