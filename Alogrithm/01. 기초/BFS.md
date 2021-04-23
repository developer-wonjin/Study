# BFS

인접한 노드들을 우선 모두 색칠해 두고 뻗어나간다.

 

## 구현

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
#include <iostream>
#include <vector>
#include <queue>

using namespace std;
const int MAX = 100;

int n, m; //정점, 간선
queue<int> Queue;
vector<int> myGraph[MAX];
bool visited[MAX];

void BFS() {

	//BFS준비
	//1. 시작점을 PUSH
	//2. 방문표시
	Queue.push(1);
	visited[1] = true;

	while (!Queue.empty()) {
		int curr = Queue.front(); Queue.pop();
		cout << curr << " ";
		for (int i = 0; i < myGraph[curr].size(); i++) {
			int next = myGraph[curr][i];

			if (!visited[next]) {
				visited[next] = true;
				Queue.push(next);
			}
		}
	}

	//BFS시작
	//3. 큐에 pop할 요소가 있으면 POP한다. 이것이 우리의 현재 위치이다.
	//4. 인접한 모든 정점에 방문했는지 확인후 
	// 방문안했으면 방문표시하고 큐에 PUSH
	//5. 3으로 반복

}


int main() {
	ios::sync_with_stdio(0);
	cin.tie(0);


	cin >> n >> m;
	
	for (int i = 0; i < m; i++) {
		int a, b;
		cin >> a >> b;
		myGraph[a].push_back(b);
		myGraph[b].push_back(a);
	}

	BFS();

	return 0;
}
```

