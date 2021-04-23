```c
// 첫 째줄 (정점의 갯수, 간선의 갯수)
// 그 이후 (정점번호, 연결된 정점)
/*

1-------2---------6
 \     / \       /
  \   /   4 --- 5
   \ /   / \ 
    3 - 7 - 8 - 9 

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

DFS: 1 -> 2 -> 3 -> 7 -> 4 -> 5 -> 6 -> 8 -> 9
BFS: 1 -> 2 -> 3 -> 4 -> 6 -> 7 -> 5 -> 8 -> 9

*/

#include<iostream>
#include<vector>
#include<queue>
using namespace std;

int n, m; //정점, 간선
const int MAX = 100;
vector<int> mygraph[MAX];
queue<int> Queue;
bool visited[MAX];


void DFS(int node) {
    //1.node 방문표시
    visited[node] = true;
    
    //2.비즈니스 로직
    cout << node << ' ';
    
    //3.node 주변을 반복문으로 확인하여 
    //  방문한 적없으면 DFS순회하기
    for (int i = 0; i < mygraph[node].size(); i++) {
        int next = mygraph[node][i];
        if (!visited[next]) {
            DFS(next);
        }
    }
}

void BFS() {
    //1. BFS준비
    //   방문표시, Queue에 PUSH
    visited[1] = true;
    Queue.push(1);

    //2. BFS시작
    while (!Queue.empty()) {
        //현재노드 구하기
        int curr = Queue.front(); Queue.pop();
        cout << curr << ' ';
        //현재노드 주변을 둘러보기
        for (int i = 0; i < mygraph[curr].size(); i++) {
            //다음 노드 구하기
            int next = mygraph[curr][i];
            
            //방문한 적없으면
            if (!visited[next]) {
                //방문표시, Queue에 PUSH
                visited[next] = true;
                Queue.push(next);
            }
        }

    }


}

int main(void) {
    ios::sync_with_stdio(0);
    cin.tie(0);

    cin >> n >> m;

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        mygraph[a].push_back(b);
        mygraph[b].push_back(a);
    }

    // 그래프 확인
    for (int i = 1; i <= n; i++) {
        cout << i << ": ";
        for (int j = 0; j < mygraph[i].size(); j++) {
            cout << mygraph[i][j] << " ";
        }
        cout << '\n';
    }

    //DFS(1);
    BFS();

    return 0;
}
```

